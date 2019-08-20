//
//  MoviesViewController.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 07/05/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    // MARK: - Subviews

    @IBOutlet private weak var actitviti: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties

    private let manager = MoviesAPIManager()
    private var movies: [Movie] = []
    private var pageNext: String = ""
    var urlString = ""

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        loadData()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        title = "Poster"
    }

    // MARK: - Private methods

    private func configureViewController() {
        tableView.isHidden = true
        actitviti.startAnimating()
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MoviesCell", bundle: Bundle.main), forCellReuseIdentifier: "moviesCell")
        tableView.layer.borderColor = UIColor.gray.cgColor
        tableView.layer.borderWidth = 0.3
    }

    private func loadData() {
        manager.getMovies(urlString: urlString, completion: { [weak self] getPopularMoviesResponse in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.movies = getPopularMoviesResponse?.results ?? []
                if let responsePage = getPopularMoviesResponse?.page {
                    self.pageNext = String(responsePage + 1)
                }
                self.tableView.reloadData()
                self.tableView.isHidden = false
                self.actitviti.stopAnimating()
            }
        })
    }

    private func loadMoreMovies() {
        manager.getMovies(urlString: "\(urlString)&page=\(pageNext)") { [weak self] (getPopularMoviesResponse) in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.movies.append(contentsOf: getPopularMoviesResponse?.results ?? [] )
                if let responsePage = getPopularMoviesResponse?.page {
                    self.pageNext = String(responsePage + 1)
                }
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension MoviesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moviesCell", for: indexPath) as? MoviesCell
        let movie = self.movies[indexPath.row]
        cell?.configure(movie: movie)
        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension MoviesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard
            let controller = storyboard.instantiateViewController(
                withIdentifier: "DetailViewController"
            ) as? MovieDetailViewController
        else {
            return
        }
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        controller.movies = self.movies[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItemIndex = movies.count - 3
        if indexPath.row == lastItemIndex {
            loadMoreMovies()
        }
    }
}
