//
//  CustomUIView.swift
//  Victor Catao
//
//  Created by Victor Catao on 21/12/2017.
//  Copyright © 2017 Victor Catao. All rights reserved.
//

import UIKit

@IBDesignable class CustomUIView: UIView {
    
    /// The thickness of the border of the view
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    /// The colour of the border of the view
    @IBInspectable var borderColor: UIColor = .clear {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    /// Indicates how rounded the corners of the view should be
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
}
