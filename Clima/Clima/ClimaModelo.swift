//
//  ClimaModelo.swift
//  Clima
//
//  Created by Marco Castañeda on 23/11/20.
//

import Foundation

struct ClimaModelo {
    let condicionID : Int
    let nombreCiudad : String
    let descripcion : String
    let temperatura: Double
    let viento : Double
    let humedad : Double
    let temp_max : Double
    let tem_min : Double
    //Se crea propiedad computada
    
    var condicionClima: String{
        
        switch condicionID {
        case 200...232:
            return "tormenta.jpg"
        case 300...321:
            return "lluvizna.jpg"
        case 701...781:
            return "nubes.jpg"
        case 800:
            return "despejado.jpeg"
        default:
            return "nubesm.jpg"
        }
    }
    
    var temperaturaDecimal: String{
        return String(format: "%.1f", temperatura)
    }
    
}
