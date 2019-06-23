//
//  ImageCaruseleViewController.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 01/06/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit
import Nuke

class ImageCaruseleViewController: UIViewController {
    var isOn = false {
        didSet {
            updateUI()
        }
    }
    @IBOutlet private weak var scrollImages: UIScrollView!

//    var detailMovie: DetailMovieResponse!
    private var detailManager = MoviesAPIManager()
    var movies: Movie?
    var apsectRatio: Posters?
//    var getImages: DetailMovieResponse!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)

        if let moviesID = movies?.id {
            // получаем данные с сервера для нужного фильма
            detailManager.getMovieImages(id: moviesID, completion: { getImagesCaruseleResponce in
                DispatchQueue.main.async {
                    // задаем ширину и высоту

                    //получаем массив постерс
                    if let images = getImagesCaruseleResponce?.posters {
                        //проходим циколом по массиву
                        for i in 0..<images.count {
                            let windowWidth = UIApplication.shared.keyWindow?.bounds.width ?? 0
                            let xOrigin = windowWidth * CGFloat(i)

                            //  создаем imageView
                            let imageCarousel = UIImageView()
                            imageCarousel.contentMode = .scaleAspectFit
                            imageCarousel.isUserInteractionEnabled = true
                            let width = UIApplication.shared.keyWindow!.bounds.width
                            let height = width / CGFloat(images[i].aspect_ratio!)
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
                                UIApplication.shared.keyWindow!.bounds.width * CGFloat(images.count), height: height)
                        }
//
                    }

                }
            })

       }

//        let view = UIView()
//        self.view.frame = CGRect(x: 10, y: 10, width: 200, height: 40)
//        self.view.addSubview(view)

        // Do any additional setup after loading the view.
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        isOn = !isOn
      }

    func updateUI() {
        if isOn {
            self.navigationController?.isNavigationBarHidden = true
            self.view.backgroundColor = .black
        } else {
            self.navigationController?.isNavigationBarHidden = false
            self.view.backgroundColor = .white
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

}
