//
//  ListMoviesViewModel.swift
//  Movies
//
//  Created by Victor Catão on 02/02/20.
//  Copyright © 2020 Victor Catao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ListMoviesModelDelegate: class {
    func reloadTableViewData()
    func openMovie(_ movie: Movie)
    func showError(message: String)
}

final class ListMoviesViewModel {
    
    enum ListMoviesCells: String {
        case header
    }
    
    // MARK: - Init
    init(title: String?, movies: [Movie]) {
        self.title = title
        self.movies = movies
    }
    
    // MARK: - Variables and Constants
    let bag = DisposeBag()
    let isLoading = BehaviorRelay<Bool>(value: false)
    var movies: [Movie] = []
    var title: String?
    var controllerTitle: String {
        return title == nil ? "movies".localized : title!
    }
    weak var delegate: ListMoviesModelDelegate?
    
    private func downloadMovieDetail(_ movie: Movie) {
        self.isLoading.accept(true)
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

// MARK: -
extension ListMoviesViewModel {
    func registerCells(tableView: UITableView) {
        tableView.register(MovieHeaderTableViewCell.self, forCellReuseIdentifier: ListMoviesCells.header.rawValue)
    }
    
    func getRowHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func getNumberOfRows() -> Int {
        return movies.count
    }
    
    func getCell(tableView: UITableView, row: Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListMoviesCells.header.rawValue) as! MovieHeaderTableViewCell
        cell.setup(movie: movies[row], hideArrowNext: false)
        return cell
    }
    
    func didSelect(row: Int) {
        downloadMovieDetail(movies[row])
    }
}
