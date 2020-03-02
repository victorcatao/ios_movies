//
//  ImageCollectionViewCell.swift
//  Base
//
//  Created by Victor Catão on 30/01/20.
//  Copyright © 2020 Victor Catao. All rights reserved.
//

import UIKit
import SnapKit

final class ImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables and Constants
    lazy var imageView: UIImageView = {
        return UIImageView(frame: .zero)
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
    private func setupView(){
        self.contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.centerY.height.width.equalToSuperview()
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    func setup(movie: Movie) {
        imageView.setImage(movieDBPathURL: movie.backdrop_path)
    }
    
}
