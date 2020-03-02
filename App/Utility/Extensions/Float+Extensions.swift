//
//  Float+Extensions.swift
//  Victor Catao
//
//  Created by Victor Catao on 06/06/19.
//  Copyright © 2019 Victor Catao. All rights reserved.
//

import Foundation

extension Float{
    
    /// Formats the Float value to a String like (R$ X.XXX,XX)
    var toBRL:String {
        get{
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "pt-BR")
            formatter.numberStyle = .currency
            return formatter.string(from: NSNumber(value: self)) ?? ""
        }
    }
    
    var toDollar:String {
        get{
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "en_US")
            formatter.numberStyle = .currency
            return formatter.string(from: NSNumber(value: self)) ?? ""
        }
    }
    
    var toInt: Int {
        get {
            return Int(self)
        }
    }
    
}
