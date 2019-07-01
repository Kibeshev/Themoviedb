//
//  ImageCaruseleViewController.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 01/06/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit
import Nuke

class ImagesCarouselViewController: UIViewController {

    // MARK: - Subviews

    @IBOutlet private weak var scrollImages: UIScrollView!

    // MARK: - Properties

    var movies: Movie?
    private var detailManager = MoviesAPIManager()
    private var apsectRatio: Posters?
    private var isOn = false {
        didSet {
            updateUI()
        }
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        getImages()
    }

    // MARK: - Actions

    @objc
    func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        isOn.toggle()
    }

    // MARK: - Private methods

    private func configureViewController() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
    }

    private func getImages() {
        if let moviesID = movies?.id {
            // получаем данные с сервера для нужного фильма
            detailManager.getMovieImages(id: moviesID, completion: { getImagesCaruseleResponce in
                DispatchQueue.main.async {
                    //получаем массив постерс
                    if let images = getImagesCaruseleResponce?.posters {
                        //проходим циколом по массиву
                        for i in 0..<images.count {
                            let windowWidth = UIApplication.shared.keyWindow?.bounds.width ?? 0
                            let xOrigin = windowWidth * CGFloat(i)
                            let imageCarousel = UIImageView()
                            imageCarousel.contentMode = .scaleAspectFit
                            imageCarousel.isUserInteractionEnabled = true
                            let width = windowWidth
                            let height = width / CGFloat(images[i].aspect_ratio ?? 0.8)
                            let yOrirgin = (self.scrollImages.bounds.height - height) / 2
                            imageCarousel.frame = CGRect(x: xOrigin, y: yOrirgin, width: width, height: height)
                            self.scrollImages.addSubview(imageCarousel)
                            if let urlStr = images[i].file_path {
                                if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(urlStr)") {
                                    Nuke.loadImage(with: imageURL, into: imageCarousel )
                                }
                            }
                            //чтоб могли листать
                            self.scrollImages.isPagingEnabled = true
                            // задаем количество перелистываний для каждой картинки в сколлле
                            self.scrollImages.contentSize = CGSize(width:
                                windowWidth * CGFloat(images.count), height: height)
                        }
                    }
                }
            })
        }
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
