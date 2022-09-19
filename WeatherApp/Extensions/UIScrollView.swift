//
//  UIScrollView.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 22.08.2022.
//
import UIKit

extension UIScrollView {

func getHeightFromDisplay(displayHeight: Double) -> Double {
    var height: Double = 0
    print(displayHeight)
    if displayHeight < 560 {
        height = 900 - displayHeight
    } else if displayHeight < 850 {
        height = 900 - displayHeight
    } else {
        height = 930 - displayHeight
    }
    return displayHeight + height
}
}
