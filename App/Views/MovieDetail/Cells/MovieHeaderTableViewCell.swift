//
//  MovieHeaderTableViewCell.swift
//  Movies
//
//  Created by Victor Catão on 01/02/20.
//  Copyright © 2020 Victor Catao. All rights reserved.
//

import UIKit
import Cosmos

final class MovieHeaderTableViewCell: UITableViewCell {
    
    // MARK: - Layout Settings
    enum Layout {
        static let moviePosterHeight: CGFloat = 120
        static let moviePosterWidth: CGFloat = 80
        static let arrowSize: CGFloat = 20
        static let starSize: Double = 15
        static let starMargin: Double = 0
    }
    
    // MARK: - Variables and Constants
    private lazy var moviePosterImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFill
        v.clipsToBounds = false
        return v
    }()
    
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.textColor = UIColor.appColor(.textColor)
        v.numberOfLines = 0
        v.font = .bigBold
        return v
    }()
    
    private lazy var taglineLabel: UILabel = {
        let v = UILabel()
        v.textColor = UIColor.appColor(.subtitleTextColor)
        v.font = .medium
        return v
    }()
    
    private lazy var popularityLabel: UILabel = {
        let v = UILabel()
        v.textColor = UIColor.appColor(.subtitleTextColor)
        v.font = .normal
        return v
    }()
    
    private lazy var voteAverageLabel: UILabel = {
        let v = UILabel()
        v.textColor = UIColor.appColor(.subtitleTextColor)
        v.font = .normal
        return v
    }()
    
    lazy var starsView: CosmosView = {
        let v = CosmosView()
        v.settings.fillMode = .half
        v.settings.starSize = Layout.starSize
        v.settings.filledColor = .yellow
        v.settings.filledBorderColor = .yellow
        v.settings.emptyBorderColor = .yellow
        v.settings.starMargin = Layout.starMargin
        v.isUserInteractionEnabled = false
        return v
    }()
    
    lazy var arrowNextImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "next")?.withRenderingMode(.alwaysTemplate)
        iv.contentMode = .scaleAspectFit
        iv.tintColor = UIColor.appColor(.textColor)
        return iv
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
        
        contentView.addSubview(moviePosterImageView)
        moviePosterImageView.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(AppSettings.Layout.defaultSpacing)
            make.height.equalTo(Layout.moviePosterHeight)
            make.width.equalTo(Layout.moviePosterWidth)
            make.bottom.equalToSuperview().offset(-AppSettings.Layout.defaultSpacing)
        }
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, taglineLabel, popularityLabel, voteAverageLabel, starsView])
        stackView.axis = .vertical
        stackView.spacing = CGFloat(AppSettings.Layout.smallSpacing)
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.leading.equalTo(moviePosterImageView.snp_trailing).offset(AppSettings.Layout.defaultSpacing)
            make.trailing.equalToSuperview().offset(-AppSettings.Layout.defaultSpacing)
            make.top.equalToSuperview().offset(AppSettings.Layout.defaultSpacing)
            make.bottom.lessThanOrEqualToSuperview()
        }
        
        contentView.addSubview(arrowNextImageView)
        arrowNextImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-AppSettings.Layout.defaultSpacing)
            make.width.height.equalTo(Layout.arrowSize)
        }
        
    }
    
    func setup(movie: Movie, hideArrowNext: Bool = true) {
        moviePosterImageView.setImage(movieDBPathURL: movie.poster_path)
        titleLabel.text = movie.title
        taglineLabel.text = movie.tagline
        popularityLabel.text = "\("popularity".localized): \(((movie.popularity ?? 0) * 1000).toInt)"
        voteAverageLabel.text = "\("vote".localized): \(movie.vote_average ?? 0)"
        starsView.rating = Double(movie.vote_average ?? 0) * 1/2
        arrowNextImageView.isHidden = hideArrowNext
    }
    
}
