//
//  ImageGradientTableViewCell.swift
//  Movies
//
//  Created by Victor Catão on 01/02/20.
//  Copyright © 2020 Victor Catao. All rights reserved.
//

import UIKit

final class ImageGradientTableViewCell: UITableViewCell {
    
    // MARK: - Layout Settings
    enum Layout {
        static let gradientViewHeightMultiply: CGFloat = 0.4
    }
    
    // MARK: - Views
    private lazy var moviePosterImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFill
        v.clipsToBounds = true
        return v
    }()
    
    private lazy var gradientView: GradientView = {
        let v = GradientView(frame: .zero)
        v.startColor = .clear
        v.endColor = .black
        return v
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
        // Adding to contentView
        self.contentView.addSubview(moviePosterImageView)
        self.contentView.addSubview(gradientView)
        
        // Constraints
        moviePosterImageView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        gradientView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(Layout.gradientViewHeightMultiply)
        }
    }
    
    func setup(movie: Movie) {
        moviePosterImageView.setImage(movieDBPathURL: movie.backdrop_path)
    }
    
}
