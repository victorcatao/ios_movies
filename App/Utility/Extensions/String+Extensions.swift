//
//  String+Extensions.swift
//  Victor Catao
//
//  Created by Victor Catao on 18/12/2017.
//  Copyright © 2017 Victor Catao. All rights reserved.
//

import UIKit

// MARK: - Variables
extension String {

    /// Returns the current String localized
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    /// Converts the String to Float
    var toFloat: Float {
        return (self as NSString).floatValue
    }
    
    /// Converts the String to Int
    var toInt: Int {
        return (self as NSString).integerValue
    }
    
    /// Converts the String to Double
    var toDouble: Double {
        return (self as NSString).doubleValue
    }
    
    /// Converts the String to Bool
    var toBool: Bool {
        return (self as NSString).boolValue
    }
    
    /// Checks if the String empty
    var isNilOrEmpty:Bool {
        get {
            return self.isEmpty
        }
    }
    
}

// MARK: - Public Functions
extension String {
    
    /// Com isso você pode fazer string[0...3] para pegar os caracteres de 0 até 3
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
}
