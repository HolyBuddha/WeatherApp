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
    //let city: CityData
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

struct CityData: Decodable {
    let name: String

}

//enum CodingKeys: String, CodingKey {
//    case feelsLike = "feels_like"
//    case tempMin =  "temp_min"
//    case tempMax = "temp_max"
//}


//struct WeatherForecastData: Decodable {
//    var list: [WeatherDataList] = []
//    let city: City
//}
//
//
//struct City: Decodable {
//    let name: String
//
//}
//struct WeatherDataList: Decodable {
//    let dt: Double
//    let main: Main
//    var weather: [Weather] = []
//    let wind: Wind
//    let dt_txt: String
//}
//
//struct Weather: Decodable {
//    let id: Int
//    let main: String
//    let description: String
//    let icon: String
//}
//
//struct Main: Decodable {
//    let temp: Double
//    let feelsLike: Double
//    let tempMin: Double
//    let tempMax: Double
//    let pressure: Int
//    let humidity: Int
//
 
//}
//
//struct Wind: Decodable {
//    let speed: Double
//    let deg: Double
//    let gust: Double
//}
//
//
//extension WeatherForecastData {
//
//    func takeDataFromJSONfor5dayForecast() -> [WeatherDataList] {
//
//        var filteredArray: [WeatherDataList] = []
//
//        for date in list {
//            let dateFromDT = NSDate(timeIntervalSince1970: date.dt)
//            let dayTimePeriodFormatter = DateFormatter()
//            dayTimePeriodFormatter.dateFormat = "HH:mm"
//            let result = dayTimePeriodFormatter.string(from: dateFromDT as Date)
//            if result == "15:00" {
//                filteredArray.append(date)
//            }
//        }
//        return filteredArray
//    }
//    func takeDataFromJSONforDailyForecast() -> [WeatherDataList] {
//
//        var filteredArray: [WeatherDataList] = []
//
//        for index in 0...8 {
//                filteredArray.append(list[index])
//            }
//        return filteredArray
//        }
//    }

