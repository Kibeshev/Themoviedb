//
//  SegmentViewController.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 07/07/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit

class SegmentViewController: UIViewController {

    // MARK: - Subviews

    @IBOutlet private weak var containerPageView: UIView!
    @IBOutlet private weak var sControl: UISegmentedControl!

    // MARK: - Properties

    var pageViewController: PageViewController?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sControl.addTarget(self, action: #selector(segmentTapped), for: .valueChanged)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PageViewController {
            self.pageViewController = vc
            vc.segmentViewController = self
        }
    }

    // MARK: - Internal

    func setIndex(index: Int) {
        sControl.selectedSegmentIndex = index
    }

    // MARK: - Actions

    @objc
    func segmentTapped(target: UISegmentedControl) {
        if target == self.sControl {
            let segmentIndex = target.selectedSegmentIndex
            pageViewController?.setPage(index: segmentIndex)
        }
    }
}
