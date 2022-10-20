//
//  String.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 15.09.2022.
//

import Foundation

extension String: Error {
    var capitalizedSentence: String {
            let firstLetter = self.prefix(1).capitalized
            let remainingLetters = self.dropFirst().lowercased()
            return firstLetter + remainingLetters
        }
}
