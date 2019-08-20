//
//  FavoritesMoviesViewController.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 03/07/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit
import RealmSwift

class FavoritesMoviesViewController: UIViewController {

    // MARK: - Subviews

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var emptyImage: UIImageView!
    @IBOutlet private weak var emptyLabel: UILabel!

    // MARK: - Properties

    private var favoriteMovies: [Movie] = []

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        loadFavoriteMovies()
        tableView.register(UINib(nibName: "MoviesCell", bundle: Bundle.main), forCellReuseIdentifier: "moviesCell")
        NotificationCenter.default.addObserver(
            self, selector: #selector(selectedFavoriteButton(_:)), name: .favoriteMoviesUpdated, object: nil)
    }

    // MARK: - Actions

    @objc
    func selectedFavoriteButton(_ notification: Notification) {
        loadFavoriteMovies()
    }

    // MARK: - Private methods

    private func loadFavoriteMovies() {
        var array: [Movie] = []
        do {
            let realm = try Realm()
            let realmObjects = realm.objects(MovieDatabaseModel.self)
            for element in realmObjects {
                let movie = Movie(
                    vote_count: nil,
                    id: element.id.value,
                    video: false,
                    vote_average: nil,
                    title: element.title,
                    popularity: nil,
                    poster_path: element.poster_path,
                    original_language: element.original_language,
                    original_title: element.original_title,
                    overview: element.overview,
                    detailMovieResponce: nil
                )
                array.append(movie)
            }
        } catch {
            print(error)
        }
        favoriteMovies = array
        reloadData()
    }

    private func reloadData() {
        if favoriteMovies.isEmpty {
            emptyLabel.isHidden = false
            emptyImage.isHidden = false
        } else {
            emptyImage.isHidden = true
            emptyLabel.isHidden = true
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension FavoritesMoviesViewController: UITableViewDelegate {

}

// MARK: - UITableViewDataSource

extension FavoritesMoviesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "moviesCell", for: indexPath
            ) as? MoviesCell
        let movieRealm = favoriteMovies[indexPath.row]
        cell?.configure(movie: movieRealm)
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath
        ) {
            do {
                let realm = try Realm()
                let realmObjects = realm.objects(MovieDatabaseModel.self)
                for element in realmObjects {
                    if element.id.value == favoriteMovies[indexPath.row].id {
                        try realm.write {
                            realm.delete(element)
                        }
                    }
                }
            } catch {
                print(error)
        }
        if editingStyle == .delete {
            favoriteMovies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            reloadData()
        }
    }
}
