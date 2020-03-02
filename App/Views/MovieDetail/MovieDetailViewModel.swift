//
//  MoviewDetailViewModel.swift
//  Movies
//
//  Created by Victor Catão on 01/02/20.
//  Copyright © 2020 Victor Catao. All rights reserved.
//

import Foundation
import RxSwift

protocol MovieDetailViewModelDelegate: class {
    func reloadTableViewData()
    func showError(message: String)
}

final class MovieDetailViewModel {
    
    // MARK: - Init
    init(movie: Movie) {
        self.movie = movie
    }
    
    // MARK: - Enums
    private enum MovieDetailCells: String {
        case imageGradient, header, information, catalog, review
    }
    
    private enum MovieDetailViewType: Int {
        case details = 0
        case reviews = 1
        case similar = 2
    }
    
    // MARK: - Variables and Constants
    private var currentViewTypeValue: MovieDetailViewType = .details
    private var similarMovies: [Movie] = []
    private var reviews: [Review] = []
    weak var delegate: MovieDetailViewModelDelegate?
    private let headerSectionIndex = 0
    private(set) var movie: Movie!
    private let bag = DisposeBag()
    var messageToShare: String {
        return String(format: "message_to_share".localized, movie.title ?? "")
    }
    
    // MARK: - DownloadData
    func downloadSimilar() {
        
        if !similarMovies.isEmpty {
            delegate?.reloadTableViewData()
            return
        }
        
        MoviesRequest.getSimilar(movieId: movie.id ?? 0).observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] list in
                guard let movies = list.results else {
                    self?.delegate?.showError(message: "unkown_error".localized)
                    return
                }
                self?.similarMovies = movies
                self?.delegate?.reloadTableViewData()
                },onError: { [weak self] error in
                    self?.delegate?.showError(message: error.localizedDescription)
            }).disposed(by: bag)
    }
    
    
    func downloadReviews() {
        if !similarMovies.isEmpty {
            delegate?.reloadTableViewData()
            return
        }
        
        MoviesRequest.getReviews(movieId: movie.id ?? 0).observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] list in
                guard let listReviews = list.results else {
                    self?.delegate?.showError(message: "unkown_error".localized)
                    return
                }
                self?.reviews = listReviews
                self?.delegate?.reloadTableViewData()
                },onError: { [weak self] error in
                    self?.delegate?.showError(message: error.localizedDescription)
            }).disposed(by: bag)
    }
    
    
}

// MARK: - TableView
extension MovieDetailViewModel {
    
    func registerCells(tableView: UITableView) {
        tableView.register(ImageGradientTableViewCell.self, forCellReuseIdentifier: MovieDetailCells.imageGradient.rawValue)
        tableView.register(MovieHeaderTableViewCell.self, forCellReuseIdentifier: MovieDetailCells.header.rawValue)
        tableView.register(InformationTableViewCell.self, forCellReuseIdentifier: MovieDetailCells.information.rawValue)
        tableView.register(CatalogTableViewCell.self, forCellReuseIdentifier: MovieDetailCells.catalog.rawValue)
        tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: MovieDetailCells.review.rawValue)
    }
    
    func getNumberOfRows(section: Int) -> Int {
        if section == headerSectionIndex { return 2 }
        
        switch currentViewTypeValue {
        case .details:
            return 2
        case .similar:
            return 1
        default:
            return reviews.count
        }
    }
    
    func getNumberOfSections() -> Int {
        return 2
    }
    
    func getHeightForCell(section: Int, row: Int) -> CGFloat {
        if section == headerSectionIndex {
            return row == 0 ? 200 : UITableView.automaticDimension
        }
        return UITableView.automaticDimension
    }
    
    func getCell(tableView: UITableView, section: Int, row: Int) -> UITableViewCell {
        if section == headerSectionIndex {
            if row == 0 { // banner with large image
                let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailCells.imageGradient.rawValue) as! ImageGradientTableViewCell
                cell.setup(movie: movie)
                return cell
            }
            // Main infos
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailCells.header.rawValue) as! MovieHeaderTableViewCell
            cell.selectionStyle = .none
            cell.setup(movie: movie)
            return cell
        }
        
        switch currentViewTypeValue {
        case .details: // Informations
            let infoCell = tableView.dequeueReusableCell(withIdentifier: MovieDetailCells.information.rawValue) as! InformationTableViewCell
            let (title, informations) = row == 0 ? movie.getOverview() : movie.getInformation()
            infoCell.setup(title: title, informations: informations)
            return infoCell
            
        case .reviews:
            let reviewCell = tableView.dequeueReusableCell(withIdentifier: MovieDetailCells.review.rawValue) as! ReviewTableViewCell
            reviewCell.setup(review: reviews[row])
            return reviewCell
            
        case .similar:
            let catalogCell = tableView.dequeueReusableCell(withIdentifier: MovieDetailCells.catalog.rawValue) as! CatalogTableViewCell
            catalogCell.setup(title: "similar".localized, movies: similarMovies)
            return catalogCell
            
        }
        
    }
    
    func getHeightForHeader(section: Int) -> CGFloat {
        if section == headerSectionIndex { return 0 }
        return 40
    }
    
    func getHeaderView(tableView: UITableView, section: Int) -> UIView? {
        if section == headerSectionIndex { return nil }
        
        let v = UIView()
        
        let segmentedControl = UISegmentedControl()
        segmentedControl.backgroundColor = UIColor.appColor(.backgroundColor)
        segmentedControl.insertSegment(withTitle: "details".localized, at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "reviews".localized, at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "similar".localized, at: 2, animated: false)
        segmentedControl.selectedSegmentIndex = currentViewTypeValue.rawValue
        segmentedControl.addTarget(self, action: #selector(didTapSegmentedControl(_:)), for: .valueChanged)
        v.addSubview(segmentedControl)
        
        segmentedControl.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(AppSettings.mediumSpacing)
            make.trailing.equalToSuperview().offset(-AppSettings.mediumSpacing)
        }
        
        return v
    }
    
}

// MARK: - SegmentedControl
extension MovieDetailViewModel {
    @objc private func didTapSegmentedControl(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            currentViewTypeValue = .details
            delegate?.reloadTableViewData()
        case 1:
            currentViewTypeValue = .reviews
            downloadReviews()
        default:
            currentViewTypeValue = .similar
            downloadSimilar()
        }
    }
}
