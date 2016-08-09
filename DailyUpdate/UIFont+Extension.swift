//
//  UIFont+Extension.swift
//  DailyUpdate
//
//  Created by Linda Zhong on 8/7/16.
//  Copyright © 2016 Linda Zhong. All rights reserved.
//

import UIKit

extension UIFont {
    static func dateFont(selected: Bool = false) -> UIFont {
        if selected {
            return UIFont(name: "Helvetica-Bold", size: 35)!
        } else {
            return UIFont(name: "Helvetica", size: 35)!
        }
    }
    
    static func contentTextFont() -> UIFont {
        return UIFont(name: "Helvetica", size: 17)!
    }
    
    static func titleTextFont() -> UIFont {
        return UIFont(name: "Helvetica-Bold", size: 17)!
    }
}
