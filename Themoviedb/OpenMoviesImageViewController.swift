//
//  OpenMoviesImageViewController.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 14/05/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit
import Nuke

class OpenMoviesImageViewController: UIViewController {
//    var isNavigationHidden = false

    private var isOn = false {
        didSet {
            updateUI()
        }
    }
    @IBOutlet private weak var openImage: UIImageView!

    var movies2: Movie!

    override func viewDidLoad() {
        super.viewDidLoad()
        // убрал larde title
        navigationItem.largeTitleDisplayMode = .never
        title = "Poster"
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        openImage.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGestureRecognizer)

        if let image = movies2.poster_path {
            if let imageURL = URL(string: "\("https://image.tmdb.org/t/p/w500")\(image)"), let imageView = openImage {
                Nuke.loadImage(with: imageURL, into: imageView )
            }

        }

    }

    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        isOn = !isOn

    }

    private func updateUI() {
        if isOn {
            self.navigationController?.isNavigationBarHidden = true
            self.view.backgroundColor = .black
        } else {
            self.navigationController?.isNavigationBarHidden = false
            self.view.backgroundColor = .white

        }
    }

}
