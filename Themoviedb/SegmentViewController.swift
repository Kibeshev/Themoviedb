//
//  SegmentViewController.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 07/07/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit

class SegmentViewController: UIViewController {

    @IBOutlet private weak var containerPageView: UIView!
    @IBOutlet private weak var sControl: UISegmentedControl!

    var pageViewController: PageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sControl.addTarget(self, action: #selector(segmentTapped), for: .valueChanged)        
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PageViewController {
            self.pageViewController = vc
            vc.segmentViewController = self
        }
    }

    @objc
    func segmentTapped(target: UISegmentedControl) {
        if target == self.sControl {
            let segmentIndex = target.selectedSegmentIndex
            pageViewController?.setPage(index: segmentIndex)
            
        }
    }

    func setIndex(index: Int) {        
        sControl.selectedSegmentIndex = index
    }

}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


