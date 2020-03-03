//
//  HomeViewController.swift
//  Base
//
//  Created by Victor Catão on 30/01/20.
//  Copyright © 2020 Victor Catao. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController, ViewCodeProtocol {
    
    // MARK: - Init
    convenience required init(viewModel: HomeViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    // MARK: - Variables and Constants
    private var viewModel: HomeViewModel!
    typealias CustomView = HomeView
    
    // MARK: - Lifecycle
    override func loadView() {
        let customView = HomeView()
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        view = customView
        
        if viewModel == nil {
            viewModel = HomeViewModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setupSubscribers()
        downloadData()
    }
    
    // MARK: - Data
    private func downloadData() {
        viewModel.downloadData()
    }
    
    // MARK: - Setup
    private func setupView() {
        title = viewModel.titleController
        viewModel.delegate = self
    }
    
    private func setupTableView() {
        viewModel.registerCells(tableView: customView.tableView)
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
    }
    
    private func setupSubscribers() {
        viewModel.isLoading.subscribe(onNext: { [weak self] isLoading in
            if isLoading {
                self?.showLoader()
            } else {
                self?.hideLoader()
            }
        }).disposed(by: self.viewModel.bag)
    }
}

// MARK: - TableView
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getHeight(row: indexPath.row)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.getCell(tableView: tableView, row: indexPath.row)
    }
}

// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {

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
    
    func openMovieList(title: String?, movies: [Movie]) {
        let vm = ListMoviesViewModel(title: title, movies: movies)
        self.navigationController?.pushViewController(ListMoviesViewController(viewModel: vm), animated: true)
    }
    
}
