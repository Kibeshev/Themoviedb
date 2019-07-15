//
//  PageViewController.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 03/07/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate {

    // MARK: - Properties

    weak var segmentViewController: SegmentViewController?
    lazy var viewControllerList = arrayVC()
    private var currentPage = 0

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setViewControllers([viewControllerList[0]], direction: .forward, animated: false, completion: nil)
    }

    // MARK: - Internal

    func setPage(index: Int) {
        if index < currentPage {
            setViewControllers([viewControllerList[index]], direction: .reverse, animated: true, completion: nil)
        } else {
            setViewControllers([viewControllerList[index]], direction: .forward, animated: true, completion: nil)
        }
        currentPage = index
    }

    // MARK: - Private methods

    private func configureViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        title = "Poster"
        self.delegate = self
    }

    private func arrayVC() -> ([UIViewController]) {

        guard let vc1 = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
            withIdentifier: "MoviesListID")) as? MoviesViewController,
            let vc2 = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
            withIdentifier: "MoviesListID")) as? MoviesViewController,
            let vc3 = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
                withIdentifier: "MoviesListID")) as? MoviesViewController else {
                    return []
        }
        vc1.urlStr = "https://api.themoviedb.org/3/movie/popular?api_key=4cb1eeab94f45affe2536f2c684a5c9e"
        vc2.urlStr = "https://api.themoviedb.org/3/movie/upcoming?api_key=4cb1eeab94f45affe2536f2c684a5c9e"
        vc3.urlStr = "https://api.themoviedb.org/3/movie/now_playing?api_key=4cb1eeab94f45affe2536f2c684a5c9e"
        return [vc1, vc2, vc3]
    }

}
