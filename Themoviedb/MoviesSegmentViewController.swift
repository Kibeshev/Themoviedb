//
//  MoviesSegmentViewController.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 07/07/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit

class MoviesSegmentViewController: UIViewController {

    // MARK: - Subviews

    @IBOutlet private weak var containerPageView: UIView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var toolBar: UIToolbar!

    // MARK: - Properties

    var pageViewController: MoviesPageViewController?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        self.segmentedControl.addTarget(self, action: #selector(segmentTapped), for: .valueChanged)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MoviesPageViewController {
            self.pageViewController = vc
        }
    }

    // MARK: - Actions

    @objc
    private func segmentTapped(target: UISegmentedControl) {
        if target == self.segmentedControl {
            let segmentIndex = target.selectedSegmentIndex
            pageViewController?.setPage(index: segmentIndex)
        }
    }

}
