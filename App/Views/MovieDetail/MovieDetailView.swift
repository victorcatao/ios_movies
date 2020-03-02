//
//  MovieDetailView.swift
//  Project
//
//  Created by Victor Catão on 01/03/20.
//  Copyright © 2020 Victor Catao. All rights reserved.
//

import UIKit

final class MovieDetailView: UIView {
    
    private(set) lazy var tableView: UITableView = {
        return UITableView(frame: UIScreen.main.bounds)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }
    
    private func createSubviews() {
        self.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
}
