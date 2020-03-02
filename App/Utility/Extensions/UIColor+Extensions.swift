//
//  UIColor+Extensions.swift
//  Victor Catao
//
//  Created by Victor Catao on 07/06/19.
//  Copyright © 2019 Victor Catao. All rights reserved.
//

import UIKit
import Foundation


extension UIColor{
    
    /// Returns a given AssetsColor
    static func appColor(_ name: AppSettings.AssetsColor) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
    
    /// Converts a hexidecimal String to UIColor
    static func hexadecimal(_ colour:String) -> UIColor? {
        
        let hex = colour.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        
        switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (255, 0, 0, 0)
        }
        return self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
