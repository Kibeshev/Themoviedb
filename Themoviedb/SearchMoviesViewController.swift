//
//  SearchMoviesViewController.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 07/07/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit

class SearchMoviesViewController: UIViewController {

    // MARK: - Subviews

    @IBOutlet private weak var tableView: UITableView?

    // MARK: - Properties

    private var searchArray: [Movie] = []
    private var searchString = ""

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }

    // MARK: - Private methods

    private func configureViewController() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.tableFooterView = UIView()
        let searchViewController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchViewController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        searchViewController.searchBar.placeholder = " Enter a movie name"
        searchViewController.searchResultsUpdater = self as? UISearchResultsUpdating
        searchViewController.searchBar.delegate = self as? UISearchBarDelegate
        searchViewController.definesPresentationContext = true
        searchString = searchViewController.searchBar.text ?? ""
    }

}

// MARK: - UITableViewDelegate

extension SearchMoviesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArray.count
    }
}

// MARK: - UITableViewDataSource

extension SearchMoviesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "TestCell", for: indexPath
            ) as? CellMovies
        let movie = self.searchArray[indexPath.row]
        cell?.configure(movie: movie)
        return cell ?? UITableViewCell()

    }
}
