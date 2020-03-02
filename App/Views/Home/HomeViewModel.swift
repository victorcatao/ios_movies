//
//  HomeViewModel.swift
//  Base
//
//  Created by Victor Catão on 30/01/20.
//  Copyright © 2020 Victor Catao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol HomeViewModelDelegate: class {
    func reloadTableViewData()
    func openMovie(_ movie: Movie)
    func openMovieList(title: String?, movies: [Movie])
    func showError(message: String)
}

final class HomeViewModel {
    
    // MARK: - Enums
    private enum HomeCells: String {
        case banner
        case catalog
    }
    
    // MARK: - Variables and Constants
    let bag = DisposeBag()
    private var genres: [Genre] = []
    private var popular: [Movie] = []
    private var topRated: [Movie] = []
    private var moviesByGenre: [Int: [Movie]] = [:] // [id_genre : [movies list]]
    let titleController = "app_name".localized
    let isLoading = BehaviorRelay<Bool>(value: false)
    weak var delegate: HomeViewModelDelegate?
    var didLoad: Bool {
        return genres.count > 0
    }
    
    // MARK: - Layout settings
    private let bannerCellHeight: CGFloat = 220
    private let indexBannerCell = 0
    private let indexTopRatedCell = 1
    
}

// MARK: - TableView
extension HomeViewModel {
    
    func registerCells(tableView: UITableView) {
        tableView.register(BannerTableViewCell.self, forCellReuseIdentifier: HomeCells.banner.rawValue)
        tableView.register(CatalogTableViewCell.self, forCellReuseIdentifier: HomeCells.catalog.rawValue)
    }
    
    func getNumberOfRows() -> Int {
        if !didLoad { return 0 } // request didn't complete yeat
        return moviesByGenre.keys.count + 2 // popular + top rated
    }
    
    func getHeight(row: Int) -> CGFloat {
        if row == indexBannerCell { return bannerCellHeight }
        return UITableView.automaticDimension
    }
    
    func getCell(tableView: UITableView, row: Int) -> UITableViewCell {
        if row == indexBannerCell { // banner = popular movies
            let bannerCell = tableView.dequeueReusableCell(withIdentifier: HomeCells.banner.rawValue) as! BannerTableViewCell
            bannerCell.setup(movies: popular)
            
            return bannerCell
        }
        
        // Catalog Cells
        let catalogCell = tableView.dequeueReusableCell(withIdentifier: HomeCells.catalog.rawValue) as! CatalogTableViewCell
        catalogCell.selectionStyle = .none
        catalogCell.delegate = self
        
        if row == indexTopRatedCell { // top rated movies
            catalogCell.setup(title: "top_rated".localized, movies: topRated)
        } else {
            let currentGenre = genres[row-2]
            let genreId = currentGenre.id ?? 0
            catalogCell.setup(title: currentGenre.name ?? "", movies: moviesByGenre[genreId] ?? [])
        }
        
        return catalogCell
    }
}

// MARK: - DownloadData
extension HomeViewModel {
    
    func downloadData() {
        isLoading.accept(true)
        Observable.zip(
            MoviesRequest.getGenreList().observeOn(MainScheduler.instance),
            MoviesRequest.getPopular().observeOn(MainScheduler.instance),
            MoviesRequest.getTopRated().observeOn(MainScheduler.instance)
        ).subscribe({ [weak self] event in
            switch event {
            case .next(let values):
                self?.genres = values.0.genres ?? []
                self?.popular = values.1.results ?? []
                self?.topRated = values.2.results ?? []
                
                // Now, we need to download the movies by genre
                Observable
                    .zip(self?.genres.map({ MoviesRequest.getMoviesForGenre(genreId: $0.id ?? 0).observeOn(MainScheduler.instance) }) ?? [])
                    .subscribe({ [weak self] event in
                        switch event {
                        case .next(let downloadedMoviesByGenre):
                            // The movies by genre has been downloaded. Now, we need to order it into the dictionary
                            let genresIds = self?.genres.map({$0.id ?? 0})
                            for (index, element) in downloadedMoviesByGenre.enumerated() {
                                let genreId = genresIds?[index] ?? 0
                                self?.moviesByGenre[genreId] = element.results ?? []
                            }
                            
                        case .error(let error):
                            self?.isLoading.accept(false)
                            self?.delegate?.showError(message: error.localizedDescription)
                        case .completed:
                            print("Completed")
                        }
                        
                        if AppSettings.isKidsApp {
                            self?.clearAllAdultsMovies()
                        }
                        
                        // Reload tableView data in UI
                        self?.delegate?.reloadTableViewData()
                        
                    }).disposed(by: self?.bag ?? DisposeBag())
                
            case .error(let error):
                self?.isLoading.accept(false)
                self?.delegate?.showError(message: error.localizedDescription)
            case .completed:
                print("Completed")
            }
        }).disposed(by: bag)
    }
    
    private func downloadMovieDetail(_ movie: Movie) {
        MoviesRequest.getMovieDetail(movieId: movie.id ?? 0).observeOn(MainScheduler.instance).subscribe(
            onNext: { [weak self] movieDetial in
                self?.isLoading.accept(false)
                self?.delegate?.openMovie(movieDetial)
            },
            onError: { [weak self] error in
                self?.isLoading.accept(false)
                self?.delegate?.showError(message: error.localizedDescription)
            }
        ).disposed(by: bag)
    }
}

// MARK: - CatalogTableViewCellDelegate
extension HomeViewModel: CatalogTableViewCellDelegate {
    func didSelectMovie(_ movie: Movie) {
        isLoading.accept(true)
        downloadMovieDetail(movie)
    }
    
    func didTapSeeAll(title: String?, movies: [Movie]) {
        delegate?.openMovieList(title: title, movies: movies)
    }
}

// MARK: - Kids
extension HomeViewModel {
    private func clearAllAdultsMovies() {
        for (genreId, _) in moviesByGenre {
            if moviesByGenre[genreId] != nil {
                self.clearAdultMoviesFromCollection(movies: &moviesByGenre[genreId]!)
            }
        }
        clearAdultMoviesFromCollection(movies: &popular)
        clearAdultMoviesFromCollection(movies: &topRated)
    }
    
    func clearAdultMoviesFromCollection(movies: inout [Movie]) {
        movies = movies.filter({$0.isMovieAdult() == false})
    }
}
