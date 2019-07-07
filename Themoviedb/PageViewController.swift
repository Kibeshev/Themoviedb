//
//  PageViewController.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 03/07/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate {

    var currentPage = 0
    weak var segmentViewController: SegmentViewController?
    var viewControllerList: [UIViewController] = [
        (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
            withIdentifier: "MoviesListID")),
        (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
            withIdentifier: "MoviesListID"))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        title = "Poster"
        self.delegate = self
        setViewControllers([viewControllerList[0]], direction: .forward, animated: false, completion: nil)

    }

    func setPage(index: Int) {
        if index < currentPage {
            setViewControllers([viewControllerList[index]], direction: .reverse, animated: true, completion: nil)
        } else {
            setViewControllers([viewControllerList[index]], direction: .forward, animated: true, completion: nil)
        }
        currentPage = index
    }
}
