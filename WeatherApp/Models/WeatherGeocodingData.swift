//
//  WeatherGeocodingData.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 30.09.2022.
//

import Foundation

struct WeatherGeocoding: Decodable {
    let name: String
    //let localNames: [String: String]
    let latitude: Double
    let longitude: Double
    //let country, state: String

    enum CodingKeys: String, CodingKey {
        case name
        //case localNames = "local_names"
        case latitude = "lat"
        case longitude = "lon"
        //case country, state
    }
}

typealias Geocoding = [WeatherGeocoding]
