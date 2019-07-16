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

    // MARK: - Subviews

    @IBOutlet private weak var openImage: UIImageView!

    // MARK: - Properties

    private var isOn = false {
        didSet {
            updateUI()
        }
    }
    var movies2: Movie?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        getImage()
    }

    // MARK: - Actions

    @objc
    private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        isOn.toggle()

    }

    // MARK: - Private methods

    private func getImage() {
        if let image = movies2?.poster_path {
            if let imageURL = URL(string: "\("https://image.tmdb.org/t/p/w500")\(image)"),
                let imageView = openImage {
                Nuke.loadImage(with: imageURL, into: imageView )
            }
        }
    }

    private func configureViewController() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(
            imageTapped(tapGestureRecognizer:)
            ))
        openImage.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGestureRecognizer)
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
