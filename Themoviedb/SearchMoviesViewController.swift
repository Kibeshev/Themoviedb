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

    private var manager = MoviesAPIManager()
    private var searchMovies: [Movie] = []
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
        tableView?.register(UINib(nibName: "MoviesCell", bundle: Bundle.main), forCellReuseIdentifier: "moviesCell")

        let searchViewController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchViewController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        searchViewController.searchBar.placeholder = " Enter a movie name"
        searchViewController.searchResultsUpdater = self as? UISearchResultsUpdating
        searchViewController.searchBar.delegate = self
        searchViewController.definesPresentationContext = true
    }
}

// MARK: - UITableViewDelegate

extension SearchMoviesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchMovies.count
    }
}

// MARK: - UITableViewDataSource

extension SearchMoviesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "moviesCell", for: indexPath
            ) as? MoviesCell
        let movie = self.searchMovies[indexPath.row]
        cell?.configure(movie: movie)
        return cell ?? UITableViewCell()

    }
}

// MARK: - UISearchBarDelegate

extension SearchMoviesViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        let urlSearch = """
        https://api.themoviedb.org/3/search/movie?api_key=4cb1eeab94f45affe2536f2c684a5c9e&query=\(searchText)
        """
        manager.getMovies(urlString: urlSearch, completion: { [weak self] getPopularMoviesResponse in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.searchMovies = getPopularMoviesResponse?.results ?? []
                self.tableView?.reloadData()
            }
        })
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard
            let controller = storyboard.instantiateViewController(
                withIdentifier: "DetailViewController"
                ) as? MovieDetailViewController
            else {
                return
        }
        self.navigationController?.pushViewController(controller, animated: true)
        controller.movies = self.searchMovies[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
