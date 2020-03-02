//
//  CustomUIImageView.swift
//  Victor Catao
//
//  Created by Victor Catao on 21/12/2017.
//  Copyright © 2017 Victor Catao. All rights reserved.
//

import UIKit

@IBDesignable class CustomUIImageView: UIImageView {

    /// Indicates if the view should be rounded
    @IBInspectable var isCircular: Bool = false {
        didSet{
            if(isCircular){
                self.layer.cornerRadius = self.frame.width/2
                self.clipsToBounds = true
            }
            else {
                self.layer.cornerRadius = 0
                self.clipsToBounds = false
            }
        }
    }
    
    /// Indicates how rounded the corners of the view should be
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
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

}
