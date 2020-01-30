//
//  Model.swift
//  WSWeather
//
//  Created by Evgeniy on 24.01.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import Foundation

class WeatherModel {
    var cityName: String
    var temperature: Double
    var weatherDescriptions: String
    
    init() {
        cityName = ""
        temperature = 0
        weatherDescriptions = ""
    }
}
