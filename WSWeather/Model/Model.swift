//
//  Model.swift
//  WSWeather
//
//  Created by Evgeniy on 24.01.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import Foundation

struct WeatherModel: Decodable {
    var cityName: String
    var temperature: Double
    
    enum CodingKeys: String, CodingKey {
        case cityName
        case temperature
    }
}
