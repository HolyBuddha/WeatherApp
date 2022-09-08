//
//  Extensions.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 12.08.2022.
//

import UIKit



extension UIView {
    func drawShadow() {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 3
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func animateCloseWith(float: CGFloat) {
        UIView.animate(withDuration: 1, animations: { () -> Void in
            self.frame.size.height = self.frame.size.height - float
            self.alpha = CGFloat(Float(0.1)) //for the fade effect
                })
            self.layoutIfNeeded()
    }
    
    
}
