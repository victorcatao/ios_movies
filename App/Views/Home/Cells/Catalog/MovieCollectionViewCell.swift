//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Victor Catão on 01/02/20.
//  Copyright © 2020 Victor Catao. All rights reserved.
//

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Layout Settings
    enum Layout {
        static let posterImageViewHeightMultiply: CGFloat = 0.7
    }
    
    // MARK: - Variables and Constants
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.font = .smallMedium
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.textColor = .gray
        label.font = .xsmall
        return label
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setups
    private func setupView() {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 0
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(posterImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
        stackView.setCustomSpacing(CGFloat(AppSettings.Layout.defaultSpacing), after: posterImageView)
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(AppSettings.Layout.defaultSpacing)
            make.trailing.equalToSuperview().offset(-AppSettings.Layout.defaultSpacing)
        }
        
        posterImageView.snp.makeConstraints { (make) in
            make.height.equalTo(self.contentView.snp.height).multipliedBy(Layout.posterImageViewHeightMultiply)
        }
    }
    
    func setup(movie: Movie) {
        posterImageView.setImage(movieDBPathURL: movie.poster_path)
        titleLabel.text = movie.title
        guard let year = movie.release_date?.split(separator: "-").first else {
            subTitleLabel.text = nil
            return
        }
        subTitleLabel.text = String(year)
    }
}
