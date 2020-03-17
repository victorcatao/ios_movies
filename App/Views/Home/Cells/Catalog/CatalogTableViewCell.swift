//
//  CatalogTableViewCell.swift
//  Movies
//
//  Created by Victor Catão on 01/02/20.
//  Copyright © 2020 Victor Catao. All rights reserved.
//

import UIKit

protocol CatalogTableViewCellDelegate: class {
    func didSelectMovie(_ movie: Movie)
    func didTapSeeAll(title: String?, movies: [Movie])
}

final class CatalogTableViewCell: UITableViewCell {
    
    // MARK: - Layout Settings
    enum Layout {
        static let seeAllButtonHeight: CGFloat = 30
        static let collectionViewHeight: CGFloat = 180
    }
    
    // MARK: - Enum
    private enum CatalogCells: String {
        case movie
    }
    
    // MARK: - Variables and constants
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = UIColor.appColor(.backgroundColor)
        return collection
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .xbigSemibold
        return label
    }()
    
    lazy var seeAllButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("see_all".localized, for: .normal)
        button.titleLabel?.font = .smallSemibold
        button.setTitleColor(UIColor.appColor(.textColor), for: .normal)
        button.addTarget(self, action: #selector(didTapSeeAll), for: .touchUpInside)
        return button
    }()
    
    private var movies: [Movie] = []
    weak var delegate: CatalogTableViewCellDelegate?
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupCollectionView()
    }
    
    // MARK: - Setups
    func setup(title: String, movies: [Movie]) {
        self.movies = movies
        self.titleLabel.text = title
        collectionView.reloadData()
    }
    
    private func setupView() {
        selectionStyle = .none
        // Adding to view's to contetView
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(collectionView)
        self.contentView.addSubview(seeAllButton)
        
        // Constraints
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(AppSettings.Layout.mediumSpacing)
        }
        
        seeAllButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-AppSettings.Layout.mediumSpacing)
            make.height.equalTo(Layout.seeAllButtonHeight)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-AppSettings.Layout.defaultSpacing)
            make.top.equalTo(self.titleLabel.snp.baseline).offset(AppSettings.Layout.defaultSpacing)
            make.height.equalTo(Layout.collectionViewHeight)
        }
    }
    
    private func setupCollectionView() {
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: CatalogCells.movie.rawValue)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    // MARK: - Actions
    @objc private func didTapSeeAll() {
        delegate?.didTapSeeAll(title: titleLabel.text, movies: movies)
    }
}

// MARK: - CollectionView Delegate and DataSource
extension CatalogTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogCells.movie.rawValue, for: indexPath) as! MovieCollectionViewCell
        cell.setup(movie: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectMovie(movies[indexPath.row])
    }
    
}

// MARK: - CollectionViewFlowLayout
extension CatalogTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/4, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
