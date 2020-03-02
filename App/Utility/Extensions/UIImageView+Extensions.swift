//
//  UIImageView+Extensions.swift
//  Victor Catao
//
//  Created by Victor Catao on 18/12/2017.
//  Copyright © 2017 Victor Catao. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    /// Loads a given url image, if the url is nil, loads the default image "placeHolderNoPhoto"
    func setImage(imageURL: String?){
        if let imgURL = imageURL {
            UIView.animate(withDuration: 0.5) {
                self.sd_setImage(with: URL(string: imgURL), completed: nil)
            }
        }
        else {
            self.image = UIImage(named: Constants.placeHolderNoPhoto)
        }
    }
    
    func setImage(movieDBPathURL: String?) {
        self.setImage(imageURL: "https://image.tmdb.org/t/p/w500\(movieDBPathURL ?? "")")
    }
    
}
