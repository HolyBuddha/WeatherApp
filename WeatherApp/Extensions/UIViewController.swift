//
//  UIViewController.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 25.09.2022.
//

import UIKit

extension UIViewController {
    func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
}
