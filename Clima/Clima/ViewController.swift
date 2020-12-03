//
//  ViewController.swift
//  Clima
//
//  Created by Marco Castañeda on 23/11/20.
//

import UIKit
import CoreLocation

class ViewController: UIViewController{
   
    var climaManager = ClimaManager()
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var imageFondo: UIImageView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelCiudad: UILabel!
    @IBOutlet weak var txtBuscar: UITextField!
    @IBOutlet weak var imageTemp: UIImageView!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var labelViento: UILabel!
    @IBOutlet weak var labelHumedad: UILabel!
    @IBOutlet weak var labelMaxima: UILabel!
    @IBOutlet weak var labelMinima: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        climaManager.delegado = self
        
        txtBuscar.delegate = self
    }
    @IBAction func obtenerUbicacion(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let ubicaciones = locations.last{
            locationManager.stopUpdatingLocation()
            let latitud = ubicaciones.coordinate.latitude
            let longitud = ubicaciones.coordinate.longitude
            //llama a la API
            climaManager.fetchClima(lat: latitud, long: longitud)
            
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}


extension ViewController: ClimaManagerDelegate{
    
    func huboError(cualError: Error) {
        print(cualError.localizedDescription)
        
        DispatchQueue.main.async {
            var des = ""
            if(cualError.localizedDescription == "The data couldn’t be read because it is missing."){
                des = "No pudimos obtener la "
            }
            self.labelDescription.text = des
            
            self.labelCiudad.text = ""
            self.labelTemp.text = "0"
            self.labelViento.text = "informacion del clima."
            self.labelHumedad.text = "Verifica lo que escribiste."
            self.labelMaxima.text = ""
            self.labelMinima.text = ""
            
            self.imageFondo.image = UIImage(named: "fondo.jpg")
        }
    }
    
    func acttualizarClima(clima: ClimaModelo) {
        
        
        DispatchQueue.main.async {
                      
            self.labelCiudad.text = clima.nombreCiudad
            self.labelTemp.text = clima.temperaturaDecimal
            self.labelDescription.text = "El clima esta \(clima.descripcion)"
            self.labelViento.text = "Vel Viento: \(clima.viento)"
            self.labelHumedad.text = "Humedad: \(clima.humedad)"
            self.labelMaxima.text = "Maxima: \(clima.temp_max)"
            self.labelMinima.text = "Minima: \(clima.tem_min)"
            self.imageFondo.image = UIImage(named: clima.condicionClima)
        }
        
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        labelCiudad.text = txtBuscar.text
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (txtBuscar.text != "") {
            
            return true
        }else{
            txtBuscar.placeholder = "Escribe una ciudad para buscar el clima"
            return false
        }
    }

    @IBAction func btnBuscar(_ sender: UIButton) {
        labelCiudad.text = txtBuscar.text
        
        climaManager.fetchClima(nombreCiudad: txtBuscar.text!)
    }
}
