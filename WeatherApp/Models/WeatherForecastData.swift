//
//  OpenWeatherAPI.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 18.07.2022.
//

import Foundation

struct WeatherForecastData: Decodable {
    let current: CurrentWeatherData
    let hourly: [HourlyWeatherData]
    let daily: [DailyWeatherData]
    let timezone: String
}

struct CurrentWeatherData: Decodable {
    let dt: Double
    let temp: Double
    let feelsLike: Double
    let humidity: Double
    let pressure: Double
    let windSpeed: Double
    let weather: [WeatherData]
    
    enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case feelsLike = "feels_like"
        case humidity
        case pressure
        case windSpeed = "wind_speed"
        case weather
    }
}

struct HourlyWeatherData: Decodable {
    let dt: Double
    let temp: Double
    let feelsLike: Double
    let weather: [WeatherData]
    
    enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case feelsLike = "feels_like"
        case weather
    }
}

struct DailyWeatherData: Decodable {
    let dt: Double
    let temp: TempData
    let feelsLike: FeelsLikeData
    let weather: [WeatherData]
    
    enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case feelsLike = "feels_like"
        case weather
    }
}

struct WeatherData: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct TempData: Decodable {
    let day: Double
    let min: Double
    let max: Double
}

struct FeelsLikeData: Decodable {
    let day: Double
}




