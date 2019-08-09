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
            self, selector: #selector(selectedFavoriteButton(_:)), name: .didReceiveData, object: nil)
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
            let myPuppy = realm.objects(MovieDatabaseModel.self)
            for i in myPuppy {
                let movie = Movie(
                    vote_count: nil,
                    id: i.id,
                    video: false,
                    vote_average: nil,
                    title: i.title,
                    popularity: nil,
                    poster_path: i.poster_path,
                    original_language: i.original_language,
                    original_title: i.original_title,
                    overview: i.overview,
                    detailMovieResponce: nil
                )
                array.append(movie)
            }

            print("получил на экране фаворитс")
        } catch {
            print("Error")
        }
        favoriteMovies = array
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension FavoritesMoviesViewController: UITableViewDelegate {

}

// MARK: - UITableViewDataSource

extension FavoritesMoviesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favoriteMovies.isEmpty {
            emptyLabel.isHidden = false
            emptyImage.isHidden = false
        } else {
            emptyImage.isHidden = true
            emptyLabel.isHidden = true
        }
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
            let myPuppy = realm.objects(MovieDatabaseModel.self)
            for i in myPuppy {
                print("стер из базы по свайпу делит")
                if i.id == favoriteMovies[indexPath.row].id {
                    try realm.write {
                        realm.delete(i)
                    }
                }
            }
            } catch {
                print("\(error)")
            }
        if editingStyle == .delete {
            favoriteMovies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            tableView.reloadData()
        }
    }
}
