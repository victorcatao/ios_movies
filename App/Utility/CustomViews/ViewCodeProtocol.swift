//
//  ViewCodeProtocol.swift
//  Project
//
//  Created by Victor Catão on 01/03/20.
//  Copyright © 2020 Victor Catao. All rights reserved.
//

import UIKit

public protocol ViewCodeProtocol {
    associatedtype CustomView: UIView
}

extension ViewCodeProtocol where Self: UIViewController {
    /// The UIViewController's custom view.
    public var customView: CustomView {
        guard let customView = view as? CustomView else {
            fatalError("ViewCode error! View should be \(CustomView.self), not \(type(of: view)).")
        }
        return customView
   }
}
