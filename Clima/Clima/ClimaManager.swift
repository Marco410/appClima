//
//  ClimaManager.swift
//  Clima
//
//  Created by Marco Castañeda on 23/11/20.
//

import Foundation

protocol ClimaManagerDelegate {
    func acttualizarClima(clima:ClimaModelo)
    
    func huboError(cualError:Error)
}

struct ClimaManager{
    
    var delegado : ClimaManagerDelegate?
    
    let Climaurl = "https://api.openweathermap.org/data/2.5/weather?appid=2a9b059c57e8bf7b15979c4995666f16&units=metric&lang=es"
    
    func fetchClima(nombreCiudad: String){
        
        let urlString = Climaurl + "&q=" + nombreCiudad
        
        realizarSolicitud(urlString: urlString)
        
    }
    
    func fetchClima(lat: Double,long: Double){
        
        let urlString = Climaurl + "&lat=" + String(lat) + "&lon=" + String(long)
        
        realizarSolicitud(urlString: urlString)
        
    }
    
    func realizarSolicitud(urlString : String){
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let tarea = session.dataTask(with: url) {(data, respuesta,error) in
                
                if error != nil {
                    delegado?.huboError(cualError: error!)
                    return
                }
                
                if let datosSeguros = data{
                    
                    if let clima = self.parseJson(climaData: datosSeguros){
                        delegado?.acttualizarClima(clima: clima)
                    }
                }
            }
            tarea.resume()
        }
    }
    
    func parseJson(climaData:Data) -> ClimaModelo? {
        let decoder = JSONDecoder()
        
        do {
           let dataDecodificada =  try  decoder.decode(ClimaData.self, from: climaData)
            let id = dataDecodificada.weather[0].id
            let nombre = dataDecodificada.name
            let descripcion = dataDecodificada.weather[0].description
            let temp = dataDecodificada.main.temp
            let viento = dataDecodificada.wind.speed
            let hume = dataDecodificada.main.humidity
            let t_max = dataDecodificada.main.temp_max
            let t_min = dataDecodificada.main.temp_min
            
            let objClima = ClimaModelo(condicionID: id, nombreCiudad: nombre, descripcion: descripcion, temperatura: temp, viento: viento, humedad:hume,temp_max: t_max,tem_min: t_min)
            
            return objClima
        } catch  {
            delegado?.huboError(cualError: error)
            return nil
        }
       
    }
    

}
