//
//  OpenWeatherAPI.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 18.07.2022.
//

import Foundation

struct WeatherForecastData: Decodable {
    var list: [WeatherDataList] = []
    let city: City
}


struct City: Decodable {
    let name: String
    
}
struct WeatherDataList: Decodable {
    let dt: Double
    let main: Main
    var weather: [Weather] = []
    let wind: Wind
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Decodable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin =  "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}

struct Wind: Decodable {
    let speed: Double
    let deg: Double
    let gust: Double
}


extension WeatherForecastData {
    
    func takeDataFromArray() -> [String] {
        
        var filteredArray: [String] = []
        
        
        for date in list {
            let dateFromDT = NSDate(timeIntervalSince1970: date.dt)
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "HH:mm"
            let result = dayTimePeriodFormatter.string(from: dateFromDT as Date)
            //if result == "15:00" { filteredArray.append(date.dt) }
            if result == "15:00" {
                let filteredDate = NSDate(timeIntervalSince1970: date.dt)
                dayTimePeriodFormatter.dateFormat = "E, d.MM"
                let answer = dayTimePeriodFormatter.string(from: filteredDate as Date)
                filteredArray.append(answer)
            }
        }
        return filteredArray
    }
}

