//
//  model.swift
//  my_weather_app
//
//  Created by Haidarov N on 12/25/24.
//

import Foundation

struct WeatherDatas: Codable {
    var address: String
    var days: [Day]
    var currentConditions: CurrentConditions
}

struct Day: Codable {
    var datetime: String
    var tempmax: Double
    var tempmin: Double
    var temp: Double
    var feelslike: Double
    var windspeed: Double
    var sunrise: String
    var sunset: String
    var conditions: String
    var description: String?
    var icon: String
    var hours: [Hour]
}

struct Hour: Codable {
    var datetime: String
    var temp: Double
    var feelslike: Double
    var windspeed: Double
    var conditions: String
    var description: String?
    var icon: String
}

struct CurrentConditions: Codable {
    var datetime: String
    var temp: Double
    var feelslike: Double
    var humidity: Double
    var windspeed: Double
    var conditions: String
    var icon: String
    var sunrise: String
    var sunset: String
}

