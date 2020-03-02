//
//  Genre.swift
//  Base
//
//  Created by Victor Catão on 31/01/20.
//  Copyright © 2020 Victor Catao. All rights reserved.
//

import Foundation

struct Genre: Name, Codable {
    var id: Int?
    var name: String?
    
    init(id: Int? = nil, name: String? = nil) {
        self.id = id
        self.name = name
    }
    
}

protocol Name {
    var name: String? { get set }
}
