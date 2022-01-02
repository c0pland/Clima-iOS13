//
//  WeatherData.swift
//  Clima
//
//  Created by Богдан Беннер on 01.01.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Float
}

struct Weather: Decodable {
    let id: Int
    let description: String
    let icon: String
}
