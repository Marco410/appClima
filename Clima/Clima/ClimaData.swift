//
//  ClimaData.swift
//  Clima
//
//  Created by Marco Castañeda on 23/11/20.
//

import Foundation

struct ClimaData:Codable{
    let name: String
    let cod: Int
    let main : Main
    let wind : Wind
    let weather : [Weather]
    let coord : Coord
}

struct Main: Codable {
    let temp : Double
    let humidity : Double
    let temp_max : Double
    let temp_min : Double
}

struct Weather:Codable {
    let description : String
    let id :Int
}

struct Wind:Codable{
    let speed : Double
}

struct Coord: Codable{
    let lat : Double
    let lon: Double
}

