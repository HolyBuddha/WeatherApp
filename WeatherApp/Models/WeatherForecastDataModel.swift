//
//  WeatherForecastDataModel.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 02.08.2022.
//

//import Foundation
//
//struct WeatherForecastData: Decodable {
//    var list: [List] = []
//}
//
//struct List: Decodable {
//    var weather: [Weather] = []
//    let main: Main
//    let wind: Wind
//    let name: String
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
//    enum CodingKeys: String, CodingKey {
//        case temp
//        case feelsLike = "feels_like"
//        case tempMin =  "temp_min"
//        case tempMax = "temp_max"
//        case pressure
//        case humidity
//    }
//}
