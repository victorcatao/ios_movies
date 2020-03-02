//
//  InformationTableViewCell.swift
//  Movies
//
//  Created by Victor Catão on 01/02/20.
//  Copyright © 2020 Victor Catao. All rights reserved.
//

import UIKit

final class InformationTableViewCell: UITableViewCell {
    
    // MARK: - Variables and Constants
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var informationsStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = CGFloat(AppSettings.defaultSpacing)
        return v
    }()
    
    private var informations: [String?: String] = [:]
    
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
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(AppSettings.mediumSpacing)
        }
        
        contentView.addSubview(informationsStackView)
        informationsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(AppSettings.defaultSpacing)
            make.leading.equalToSuperview().offset(AppSettings.mediumSpacing)
            make.bottom.trailing.equalToSuperview().offset(-AppSettings.mediumSpacing)
        }
    }
    
    func setup(title: String, informations: [String?: String]) {
        
        // Removing all subviews from stackview to prevent reusable bugs
        informationsStackView.arrangedSubviews.forEach({$0.removeFromSuperview()})
        
        self.informations = informations
        self.titleLabel.text = title
        for (type, information) in informations {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = CGFloat(AppSettings.defaultSpacing)
            stackView.alignment = .top
            
            let typeLabel = getTypeLabel(text: type)
            let informationLabel = getInfoLabel(text: information)
            stackView.addArrangedSubview(typeLabel)
            stackView.addArrangedSubview(informationLabel)
            
            informationsStackView.addArrangedSubview(stackView)
        }
        
    }
    
    // Helpers
    private func getTypeLabel(text: String?) -> UILabel {
        let label = UILabel()
        label.text = text
        label.isHidden = text == nil
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16)
        label.snp.makeConstraints { (make) in
            make.width.equalTo(100)
        }
        return label
    }
    
    private func getInfoLabel(text: String?) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = UIColor.appColor(.subtitleTextColor)
        return label
    }
}
