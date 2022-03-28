//
//  WeatherData.swift
//  Clima
//
//  Created by Arda Büyükhatipoğlu on 26.03.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

//Used to parse JSON data
import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Float
    let feels_like: Float
    let humidity: Float
}

struct Weather: Decodable {
    let description: String
    let id: Int
}
