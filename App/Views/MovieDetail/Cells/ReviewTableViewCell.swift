//
//  ReviewTableViewCell.swift
//  Movies
//
//  Created by Victor Catão on 01/02/20.
//  Copyright © 2020 Victor Catao. All rights reserved.
//

import UIKit
import Cosmos

final class ReviewTableViewCell: UITableViewCell {
    
    lazy var authorNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    lazy var cosmosView: CosmosView = {
        let v = CosmosView()
        v.settings.fillMode = .half
        return v
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    // MARK: - Setups
    private func setupView() {
        selectionStyle = .none
        contentView.addSubview(authorNameLabel)
        contentView.addSubview(cosmosView)
        contentView.addSubview(commentLabel)
        
        authorNameLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(AppSettings.mediumSpacing)
            make.top.equalToSuperview().offset(AppSettings.bigSpacing)
            make.trailing.equalToSuperview().offset(-AppSettings.mediumSpacing)
        }
        
        cosmosView.snp.makeConstraints { (make) in
            make.leading.equalTo(authorNameLabel.snp.leading)
            make.top.equalTo(authorNameLabel.snp.bottom).offset(AppSettings.defaultSpacing)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
        
        commentLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(authorNameLabel.snp.leading)
            make.top.equalTo(cosmosView.snp.bottom).offset(AppSettings.mediumSpacing)
            make.trailing.equalToSuperview().offset(-AppSettings.mediumSpacing)
            make.bottom.equalToSuperview()
        }
    }
    
    func setup(review: Review) {
        authorNameLabel.text = review.author
        cosmosView.rating = Double.random(in: 1...5)
        commentLabel.text = review.content
    }
    
}
