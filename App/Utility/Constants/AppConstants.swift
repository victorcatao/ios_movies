//
//  APPConstants.swift
//  Victor Catao
//
//  Created by Victor Catao on 18/12/2017.
//  Copyright © 2017 Victor Catao. All rights reserved.
//

import UIKit

enum Constants {
    static let noResultsImage: String = "no-results-icon"
    static let placeHolderNoPhoto: String = "placeholder-no-photo"
}

enum AppSettings {
    static let defaultSpacing: Int = 8
    
    static let mediumSpacing: Int  = defaultSpacing * 2
    
    static let bigSpacing: Int  = defaultSpacing * 3
    
    static var isKidsApp: Bool {
        #if MoviesKids
        return true
        #else
        return false
        #endif
    }
    
    static let apiToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1NzQ3OWI1MDI5ODQ4ZjU3ODVhN2M0YWNjYTc2YjM2YiIsInN1YiI6IjVlMmY1ZTUzNGNhNjc2MDAxNDQ5ZDEzZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.AMzSLPf-SFTIAJM-9KDGxKWB7oEcEzLNSn5c-UelOb0"
    
    enum AssetsColor:String {
        case backgroundColor
        case subtitleTextColor
        case textColor
    }
}
