//
//  WeatherModel.swift
//  Clima
//
//  Created by Arda Büyükhatipoğlu on 26.03.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let weatherId: Int
    let temperature: Float
    
    var temparatureString: String{
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch weatherId {
        case 200...232:
            return "cloud.bolt.rain.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "cloud.fog.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.bolt.fill"
        default:
            return "cloud.fill"
        }
    }
    
}
