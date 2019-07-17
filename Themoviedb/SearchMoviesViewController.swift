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

    fileprivate var manager = MoviesAPIManager()
    fileprivate var searchArray: [Movie] = []
    fileprivate var searchString = ""

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
        tableView?.register(UINib(nibName: "CellMoviesXIB", bundle: Bundle.main), forCellReuseIdentifier: "cell")

        let searchViewController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchViewController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        searchViewController.searchBar.placeholder = " Enter a movie name"
        searchViewController.searchResultsUpdater = self as? UISearchResultsUpdating
        searchViewController.searchBar.delegate = self as? UISearchBarDelegate
        searchViewController.definesPresentationContext = true
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
            withIdentifier: "Cell", for: indexPath
            ) as? CellMoviesXIB
        let movie = self.searchArray[indexPath.row]
        cell?.configure(movie: movie)
        return cell ?? UITableViewCell()

    }
}

extension SearchMoviesViewController: UISearchBarDelegate {

//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        let searchAPI = """
//        https://api.themoviedb.org/3/search/movie?api_key=4cb1eeab94f45affe2536f2c684a5c9e&query=\(searchText)
//        """
//        manager.getMovie(urlString: searchAPI, completion: { [weak self] getPopularMoviesResponse in
//            guard let self = self else {
//                return
//            }
//            DispatchQueue.main.async {
//                self.searchArray = getPopularMoviesResponse?.results ?? []
//                self.tableView?.reloadData()
//            }
//        })
//    }
}
