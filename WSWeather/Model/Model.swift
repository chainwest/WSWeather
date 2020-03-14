//
//  Model.swift
//  WSWeather
//
//  Created by Evgeniy on 24.01.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import Foundation

struct Current: Codable {
    var temperature: Double
}

struct WeatherModel: Codable {
    var current: Current
}
