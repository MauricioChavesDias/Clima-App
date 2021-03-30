//
//  WeatherModel.swift
//  Clima
//
//  Created by Mauricio Dias on 19/3/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    //Compute Property
    var conditionName: String {
        switch conditionID {
        case (200...232):
            return "cloud.bolt.rain"
        case (300...321):
            return "cloud.drizzle"
        case (500...501):
            return "cloud.rain"
        case (502...504):
            return "cloud.heavyrain"
        case (511...531):
            return "cloud.snow"
        case (600...622):
            return "cloud.snow"
        case (701...771):
            return "cloud.fog"
        case 781:
            return "tornado"
        case 800:
            return "sun.max"
        case (801...804):
            return "cloud"
        default:
            return "cloud"
        }
    }
    
    

}
