//
//  OpenWeatherAPI.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 18.07.2022.
//

import Foundation

struct WeatherData: Decodable {
    var weather: [Weather] = []
    let main: Main
    let wind: Wind
    let name: String
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

struct weatherConditions {
    static let weatherIDs: [Int: String] = [
        200: "Гроза с небольшим дождем",
        201: "Гроза с дождем",
        202: "Гроза с сильным дождем",
        210: "Небольшая гроза",
        211: "Гроза",
        212: "Сильная гроза",
        221: "Сильнейшая гроза",
        230: "Гроза с небольшим дождем",
        231: "Гроза с дождем",
        232: "Гроза с сильным дождем",
        300: "Легкий моросящий дождь",
        301: "Мелкий дождь",
        302: "Сильный моросящий дождь",
        310: "Интенсивный моросящий дождь",
        311: "Моросящий дождь",
        312: "Сильный моросящий дождь",
        313: "Ливень и изморось",
        314: "Сильный ливень и изморось",
        321: "Ливневый дождь",
        500: "Небольшой дождь",
        501: "Умеренный дождь",
        502: "Сильный интенсивный дождь",
        503: "Очень сильный дождь",
        504: "Экстремальный дождь",
        511: "Ледянной дождь",
        520: "Непродолжительный ливень",
        521: "Проливной дождь",
        522: "Продолжительный ливень",
        531: "Сильнейший ливень",
        600: "Небольшой снег",
        601: "Снег",
        602: "Сильный снег",
        611: "Мокрый снег",
        612: "Дождь со снегом",
        615: "Небольшой дождь и снег",
        616: "Дождь и снег",
        620: "Небольшой снегопад",
        621: "Снегопад",
        622: "Сильный снегопад",
        701: "Пасмурность",
        711: "Дым",
        721: "Дымка",
        731: "Песок, пылевые вихри",
        741: "Туман",
        751: "Песок",
        761: "Пыль",
        762: "Вулканический пепел",
        771: "Шквал",
        781: "Торнадо",
        800: "Чистое небо",
        801: "Немного облаков",
        802: "Рассеянные облака",
        803: "Рванные облака",
        804: "Пасмурные облака"
    ]
}
