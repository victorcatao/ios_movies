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
    
    enum Layout {
        static let smallSpacing: Int   = defaultSpacing / 2
        static let defaultSpacing: Int = 8
        static let mediumSpacing: Int  = defaultSpacing * 2
        static let bigSpacing: Int     = defaultSpacing * 3
    }
    
}

extension UIFont {
    // Default
    static let xsmall = UIFont.systemFont(ofSize: 10)
    static let small  = UIFont.systemFont(ofSize: 12)
    static let normal = UIFont.systemFont(ofSize: 14)
    static let medium = UIFont.systemFont(ofSize: 16)
    static let big    = UIFont.systemFont(ofSize: 18)
    static let xbig   = UIFont.systemFont(ofSize: 20)
    
    // Medium
    static let xsmallMedium = UIFont.systemFont(ofSize: 10, weight: .medium)
    static let smallMedium  = UIFont.systemFont(ofSize: 12, weight: .medium)
    static let normalMedium = UIFont.systemFont(ofSize: 14, weight: .medium)
    static let mediumMedium = UIFont.systemFont(ofSize: 16, weight: .medium)
    static let bigMedium    = UIFont.systemFont(ofSize: 18, weight: .medium)
    static let xbigMedium   = UIFont.systemFont(ofSize: 20, weight: .medium)
    
    // Semibold
    static let xsmallSemibold = UIFont.systemFont(ofSize: 10, weight: .semibold)
    static let smallSemibold  = UIFont.systemFont(ofSize: 12, weight: .semibold)
    static let normalSemibold = UIFont.systemFont(ofSize: 14, weight: .semibold)
    static let mediumSemibold = UIFont.systemFont(ofSize: 16, weight: .semibold)
    static let bigSemibold    = UIFont.systemFont(ofSize: 18, weight: .semibold)
    static let xbigSemibold   = UIFont.systemFont(ofSize: 20, weight: .semibold)
    
    // Bold
    static let xsmallBold = UIFont.systemFont(ofSize: 10, weight: .bold)
    static let smallBold  = UIFont.systemFont(ofSize: 12, weight: .bold)
    static let normalBold = UIFont.systemFont(ofSize: 14, weight: .bold)
    static let mediumBold = UIFont.systemFont(ofSize: 16, weight: .bold)
    static let bigBold    = UIFont.systemFont(ofSize: 18, weight: .bold)
    static let xbigBold   = UIFont.systemFont(ofSize: 20, weight: .bold)
}

