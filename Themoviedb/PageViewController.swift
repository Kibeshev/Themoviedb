//
//  PageViewController.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 03/07/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var currentPage = 0
    weak var segmentViewController: SegmentViewController?
    var viewControllerList: [UIViewController] = [
        (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
            withIdentifier: "MoviesListID")),
        (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
            withIdentifier: "RedVCTestID"))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        title = "Poster"
        self.dataSource = self
        self.delegate = self
        setViewControllers([viewControllerList[0]], direction: .forward, animated: false, completion: nil)

        // Do any additional setup after loading the view.
    }

    func setPage(index: Int) {
        if index < currentPage {
            setViewControllers([viewControllerList[index]], direction: .reverse, animated: true, completion: nil)
        } else {
            setViewControllers([viewControllerList[index]], direction: .forward, animated: true, completion: nil)
        }
        currentPage = index
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = viewControllerList.lastIndex(of: viewController) ?? 0
        guard currentIndex > 0 else {
            return nil
        }

        segmentViewController?.setIndex(index: currentIndex - 1)
        return viewControllerList[currentIndex - 1]

    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = viewControllerList.lastIndex(of: viewController) ?? 0
        guard currentIndex < viewControllerList.count - 1 else {
            return nil
        }
        segmentViewController?.setIndex(index: currentIndex + 1)
        return viewControllerList[currentIndex + 1]
    }

//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        <#code#>
//    }
}
