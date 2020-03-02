//
//  BannerTableViewCell.swift
//  Base
//
//  Created by Victor Catão on 30/01/20.
//  Copyright © 2020 Victor Catao. All rights reserved.
//

import UIKit
import SnapKit

final class BannerTableViewCell: UITableViewCell {

    private enum BannerCells: String {
        case image
    }
    
    // MARK: - Variables and constants
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        return collection
    }()
    
    private var timer = Timer()
    private var counter = 0
    private var movies: [Movie] = []
    
    // MARK: - Settings
    private let carouselTimeInterval: TimeInterval = 2.5
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupCollectionView()
        setupCarousel()
    }
    
    // MARK: - Setups
    func setup(movies: [Movie]) {
        self.movies = movies
        collectionView.reloadData()
    }
    
    private func setupView() {
        self.contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.trailing.equalTo(self.contentView)
            make.leading.equalTo(self.contentView)
            make.top.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView)
        }
    }
    
    private func setupCollectionView() {
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: BannerCells.image.rawValue)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    // MARK: - Carousel
    private func setupCarousel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.timer = Timer.scheduledTimer(timeInterval: self.carouselTimeInterval,
                                              target: self,
                                              selector: #selector(self.moveToNextImage),
                                              userInfo: nil,
                                              repeats: true)
        }
    }
    
    @objc func moveToNextImage() {
        if counter >= movies.count {
            counter = 0
        }
        
        let index = IndexPath(item: counter, section: 0)
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        counter += 1
    }

}

// MARK: - CollectionView Delegate and DataSource
extension BannerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCells.image.rawValue, for: indexPath) as! ImageCollectionViewCell
        cell.setup(movie: movies[indexPath.row])
        return cell
    }
}

// MARK: - CollectionViewFlowLayout
extension BannerTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
