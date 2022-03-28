//
//  WeatherManager.swift
//  Clima
//
//  Created by Arda Büyükhatipoğlu on 25.03.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let apikey = "******Enter api key here*****"
    var delegate: WeatherManagerDelegate?
    
    func getWeather(cityName: String){
        let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=\(apikey)&units=metric&q="
        let urlString = "\(weatherUrl)\(cityName)"
        performRequest(with: urlString)
    }
    
    func getWeatherWithLocation(latitude lat: String, longitude lon: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apikey)&units=metric"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        
        //1. Create Url
        if let url = URL(string: urlString){
            
            //2. Create Url Session
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url, completionHandler: {(data: Data?, urlResponse: URLResponse?, error: Error?) in
                
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if let parsedWeather = parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: parsedWeather)
                    }
                }
            })
            
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let weatherModel = WeatherModel(cityName: decodedData.name, weatherId: decodedData.weather[0].id, temperature: decodedData.main.temp)
            return weatherModel
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
