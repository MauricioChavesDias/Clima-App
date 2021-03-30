//
//  WeatherManager.swift
//  Clima
//
//  Created by Mauricio Dias on 19/3/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error : Error)
}

struct WeatherManager {
    
    //HTTPS is safer
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?"
    let apiKey = "PUT_YOUR_API_KEY_HERE"
    var delegate: WeatherManagerDelegate?
    
    
    func fetchWeather(cityName: String) {
        let url = weatherURL + apiKey
        let urlString = "\(url)&units=metric&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let url = weatherURL + apiKey
        let urlString = "\(url)&units=metric&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    //in order to use the API this methods must be implemented.
    func performRequest(with urlString: String) {
        //1. Create a URL
        //2. Create a URLSession
        //3. Give the session a task
        //4. Start the task
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return //exit
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            
            return weather
        } catch  {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
