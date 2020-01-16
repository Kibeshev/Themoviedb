//
//  SecondViewController.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 12/05/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit
import Nuke
import Foundation
import RealmSwift

class MovieDetailViewController: UIViewController, UIScrollViewDelegate {

    // MARK: - Subviews

    @IBOutlet private weak var stackViewRuntime: UIStackView!
    @IBOutlet private weak var stackViewBudget: UIStackView!
    @IBOutlet private weak var stackViewRevenue: UIStackView!
    @IBOutlet private weak var revenueLabelTitle: UILabel!
    @IBOutlet private weak var originalLanguageLabel: UILabel?
    @IBOutlet private weak var runtimeLabel: UILabel!
    @IBOutlet private weak var budgetLabel: UILabel!
    @IBOutlet private weak var revenueLabel: UILabel!
    @IBOutlet private weak var descriptionsLabel: UILabel!
    @IBOutlet private weak var scrollVIewOutlet: UIScrollView!
    @IBOutlet private weak var detailScreenImageMovies: UIImageView!
    @IBOutlet private weak var nameMoviesDetailScreen: UILabel!
    @IBOutlet private weak var showImagesButton: UIButton!
    @IBOutlet private weak var playVideoButton: UIButton!

    // MARK: - Properties

    var movie: Movie?
    private let heartButton = UIButton()
    private var detailMovie: DetailMovieResponse?
    private var detailManager = MoviesAPIManager()
    private var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        return formatter
    }()
    private var isAddedToFavorites = false

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadData()

        }

    // MARK: - Actions

    @objc
    func favoritesButtonTapped(sender: UIBarButtonItem) {
        updateFavoritesState()
    }

    @IBAction private func playVideoButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(
            withIdentifier: "webViewID"
            ) as? WebViewController else {
            return
        }
        self.navigationController?.pushViewController(controller, animated: true)
        controller.webViewVideo = self.detailMovie?.videos?.results.first
    }

    @IBAction private func showImagesButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(
            withIdentifier: "imageCarusele") as? ImagesCarouselViewController else {
            return
        }
        self.navigationController?.pushViewController(controller, animated: true)
        controller.movies = self.movie
    }

    @objc
    private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(
            withIdentifier: "BigMovieOpenTap") as? OpenMoviesImageViewController else {
            return
        }
        self.navigationController?.pushViewController(controller, animated: true)
        controller.movie = self.movie
    }

    // MARK: - Private methods

    private func updateFavoritesState() {
        let realm = try? Realm()
        let movieDatabaseModel = MovieEntry()
        if isAddedToFavorites == false {
            heartButton.setImage(UIImage(named: "favoritesButton"), for: .normal)
            let barButton = UIBarButtonItem(customView: heartButton)
            self.navigationItem.rightBarButtonItem = barButton
            movieDatabaseModel.originalTitle = movie?.originalTitle
            movieDatabaseModel.overview = movie?.overview
            movieDatabaseModel.originalLanguage = movie?.originalLanguage
            movieDatabaseModel.posterPath = movie?.posterPath
            movieDatabaseModel.id.value = movie?.id
            try? realm?.write {
                realm?.add(movieDatabaseModel)
            }
            isAddedToFavorites = true
        } else {
            guard let rewriteMovieDataBase = realm?.objects(MovieEntry.self) else {
                return
            }
            for element in rewriteMovieDataBase {
                heartButton.setImage(UIImage(named: "addFavorites"), for: .normal)
                let barButton = UIBarButtonItem(customView: heartButton)
                self.navigationItem.rightBarButtonItem = barButton
                if element.id.value == movie?.id {
                    try? realm?.write {
                        realm?.delete(element)
                    }
                }
                isAddedToFavorites = false
            }
        }
        NotificationCenter.default.post(name: .favoriteMoviesUpdated, object: nil)
    }

    private func configureUI() {

        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(imageTapped(tapGestureRecognizer:))
        )

        detailScreenImageMovies.isUserInteractionEnabled = true
        detailScreenImageMovies.addGestureRecognizer(tapGestureRecognizer)
        descriptionsLabel.text = movie?.overview
        nameMoviesDetailScreen.text = movie?.originalTitle
        if let image = movie?.posterPath,
            let imageURL = URL(string: "\("https://image.tmdb.org/t/p/w500")\(image)") {
            Nuke.loadImage(with: imageURL, into: detailScreenImageMovies)
        }
        playVideoButton.backgroundColor = .clear
        playVideoButton.layer.borderWidth = 0.5
        playVideoButton.layer.borderColor = UIColor.gray.cgColor
        showImagesButton.backgroundColor = .clear
        showImagesButton.layer.borderWidth = 0.5
        showImagesButton.layer.borderColor = UIColor.gray.cgColor
        navigationItem.largeTitleDisplayMode = .never

        heartButton.setImage(UIImage(named: "addFavorites"), for: .normal)
        heartButton.addTarget(
            self, action: #selector(favoritesButtonTapped(sender:)), for: UIControl.Event.touchUpInside
        )
        let barButton = UIBarButtonItem(customView: heartButton)
        self.navigationItem.rightBarButtonItem = barButton

        let realm = try? Realm()
        guard let realmObjects = realm?.objects(MovieEntry.self) else {
            return }
        for element in realmObjects {
            if element.id.value == movie?.id {
                heartButton.setImage(UIImage(named: "favoritesButton"), for: .normal)
                let barButton = UIBarButtonItem(customView: heartButton)
                self.navigationItem.rightBarButtonItem = barButton
                isAddedToFavorites = true
            }
        }
    }

    private func loadData() {
        guard let id = movie?.id else {
           return
        }
        let url = """
        https://api.themoviedb.org/3/movie/\(id)?api_key=4cb1eeab94f45affe2536f2c684a5c9e&append_to_response=videos
        """

        detailManager.detailGetMovie(urlString: url, completion: { [weak self] detailMovieResponse in
                guard let self = self else {
                    return
                }
                DispatchQueue.main.async {
                    self.originalLanguageLabel?.text = detailMovieResponse?.originalLanguage
                    self.fillBudget(budget: detailMovieResponse?.budget)
                    self.fillRevenue(revenue: detailMovieResponse?.revenue)
                    self.fillRunrime(runtime: detailMovieResponse?.runtime)
                    self.detailMovie = detailMovieResponse
                }
        })
    }

    private func fillBudget(budget: Int?) {
        guard let budget = budget else {
            return
        }
        guard let formattedNumber = formatter.string(from: NSNumber(value: budget)) else {
            return
        }
        budgetLabel.text = "$\(formattedNumber)"
        if budget == 0 {
            stackViewBudget.arrangedSubviews.forEach({ (view) in
                view.removeFromSuperview()
            })
        }

    }

    private func fillRevenue(revenue: Int?) {
        guard let revenue = revenue, let formattedNumber = formatter.string(from: NSNumber(value: revenue)) else {
            return
        }
        revenueLabel.text = "$\(formattedNumber)"
        if revenue < 100 {
            self.stackViewRevenue.arrangedSubviews.forEach({ (view) in
                view.removeFromSuperview()
            })
        }
    }

    private func fillRunrime(runtime: Int?) {
        guard let runtime = runtime else {
            stackViewRuntime.arrangedSubviews.forEach({ (view) in
                view.removeFromSuperview()
            })
            return
        }
        runtimeLabel.text = String(describing: "\(runtime) minute")

    }

}
