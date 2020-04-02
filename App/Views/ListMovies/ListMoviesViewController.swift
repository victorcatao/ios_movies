//
//  ListMoviesViewController.swift
//  Movies
//
//  Created by Victor Catão on 02/02/20.
//  Copyright © 2020 Victor Catao. All rights reserved.
//

import UIKit
import RxSwift

final class ListMoviesViewController: UIViewController, ViewCodeProtocol {
    
    convenience required init(viewModel: ListMoviesViewModelType) {
        self.init()
        self.viewModel = viewModel
    }
    
    // MARK: - Variables and Constants
    private var viewModel: ListMoviesViewModelType!
    typealias CustomView = ListMoviesView
    private let disposeBag = DisposeBag()

    // MARK: - Lifecycle
    override func loadView() {
        let customView = ListMoviesView()
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubscribers()
        setupTableView()
    }
    
    // MARK: - Setup
    private func setupView() {
        self.title = viewModel.controllerTitle
    }
    
    private func setupTableView() {
        viewModel.registerCells(tableView: customView.tableView)
    }
    
    private func setupSubscribers() {
        viewModel
            .isLoading
            .asDriver()
            .drive(onNext: { [weak self] (isLoading) in
                isLoading ? self?.showLoader() : self?.hideLoader()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - TableView
extension ListMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getRowHeight()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.getCell(tableView: tableView, row: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(row: indexPath.row)
    }
}

// MARK: - ListMoviesModelDelegate
extension ListMoviesViewController: ListMoviesModelDelegate {
    func showError(message: String) {
        self.showErrorAlert(message: message)
    }
    
    func reloadTableViewData() {
        hideLoader()
        customView.tableView.reloadData()
    }
    
    func openMovie(_ movie: Movie) {
        self.navigationController?.pushViewController(MovieDetailViewController(viewModel: MovieDetailViewModel(movie: movie)), animated: true)
    }
}
