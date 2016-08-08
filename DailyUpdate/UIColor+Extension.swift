//
//  UIColor+Extension.swift
//  DailyUpdate
//
//  Created by Linda Zhong on 8/7/16.
//  Copyright © 2016 Linda Zhong. All rights reserved.
//

import UIKit

extension UIColor {
    static func borderColor() -> UIColor {
        return UIColor(red: 158.0/255, green: 158.0/255, blue: 158.0/255, alpha: 0.6)
    }
    
    static func invalidDailyUpdateColor() -> UIColor {
        return UIColor(red: 227.0/255, green: 235.0/255, blue: 244.0/255, alpha: 1.0)
    }
    
    static func blankDailyUpdateColor() -> UIColor {
        return UIColor(red: 232.0/255, green: 232.0/255, blue: 232.0/255, alpha: 1.0)
    }
}