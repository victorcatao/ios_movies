//
//  MoviewDetailViewController.swift
//  Movies
//
//  Created by Victor Catão on 01/02/20.
//  Copyright © 2020 Victor Catao. All rights reserved.
//

import UIKit

final class MovieDetailViewController: UIViewController, ViewCodeProtocol {
    
    // MARK: - Init
    convenience required init(viewModel: MovieDetailViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    // MARK: - Variables and Constants
    private var viewModel: MovieDetailViewModel!
    typealias CustomView = MovieDetailView
    
    // MARK: - Lifecycle
    override func loadView() {
        let customView = MovieDetailView()
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
        setupTableView()
    }
    
    // MARK: - Setup
    private func setupView() {
        viewModel.delegate = self
    }
    
    private func setupNavigationBar() {
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        navigationItem.rightBarButtonItem = shareButton
    }
    
    private func setupTableView() {
        viewModel.registerCells(tableView: customView.tableView)
        customView.tableView.separatorStyle = .none
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
    }
    
    // MARK: - Actions
    @objc private func didTapShare() {
        let activityViewController = UIActivityViewController(activityItems: [self.viewModel.messageToShare], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}

// MARK: - TableView
extension MovieDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewModel.getHeaderView(tableView: tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.getHeightForHeader(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getHeightForCell(section: indexPath.section, row: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows(section: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.getCell(tableView: tableView, section: indexPath.section, row: indexPath.row)
    }
}

// MARK: - HomeViewModelDelegate
extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func showError(message: String) {
        self.showErrorAlert(message: message)
    }
    
    func reloadTableViewData() {
        self.customView.tableView.reloadSections(IndexSet(integersIn: 1...1), with: .fade)
    }
}
