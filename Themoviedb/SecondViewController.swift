//
//  SecondViewController.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 12/05/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit
import Nuke
import Foundation


class SecondViewController: UIViewController, UIScrollViewDelegate{

    
    @IBAction func showImagesButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "imageCarusele") as? ImageCaruseleViewController
        self.navigationController?.pushViewController(controller!, animated: true)
        controller?.movies = self.movies
//        let ImageCaruseleViewController:UIViewController = UIViewController()
//        self.navigationController?.pushViewController(ImageCaruseleViewController, animated: true)
//        self.navigationController?.popViewController(animated: true)
        }

    @IBOutlet weak var stackViewBudget: UIStackView!
    @IBOutlet weak var stackViewRevenue: UIStackView!
    @IBOutlet weak var revenueLabelTitle: UILabel!
    @IBOutlet private weak var originalLanguageLabel: UILabel!
    @IBOutlet private weak var runtimeLabel: UILabel!
    @IBOutlet private weak var budgetLabel: UILabel!
    @IBOutlet private weak var revenueLabel: UILabel!
    @IBOutlet private weak var descriptionsLabel: UILabel!
    @IBOutlet private weak var scrollVIewOutlet: UIScrollView!
    @IBOutlet private weak var detailScreenImageMovies: UIImageView!
    @IBOutlet private weak var nameMoviesDetailScreen: UILabel!
    
    @IBOutlet private weak var showImagesButton: UIButton!
    @IBOutlet private weak var playVideoButtonSettingsBorderColor: UIButton!
    //    var detailMovies = DetailMovieResponse!
    var detailMovie: DetailMovieResponse!
    var movies: Movie!
    private var detailManager = MoviesAPIManager()
    
    
    
    
    @IBAction private func playVideoButton(_ sender: Any) {
//        let url1 = URL(string: "\("http://youtube.com/watch?v=")\(viedeos.first)")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "webViewID") as? WebViewController
        self.navigationController?.pushViewController(controller!, animated: true)
        controller?.webViewVideo = self.detailMovie.videos?.results.first
        
        
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        playVideoButtonSettingsBorderColor.backgroundColor = .clear
        playVideoButtonSettingsBorderColor.layer.borderWidth = 0.5
        playVideoButtonSettingsBorderColor.layer.borderColor = UIColor.gray.cgColor
        
        showImagesButton.backgroundColor = .clear
        showImagesButton.layer.borderWidth = 0.5
        showImagesButton.layer.borderColor = UIColor.gray.cgColor
        
        if let moviesID = movies.id {
            let url = "https://api.themoviedb.org/3/movie/\(moviesID)?api_key=4cb1eeab94f45affe2536f2c684a5c9e&append_to_response=videos"
            
            detailManager.detailGetMovie(urlString: url, completion: { detailMovieResponce in
                DispatchQueue.main.async {
                    if let runtime = detailMovieResponce?.runtime{
                    self.runtimeLabel.text = String(describing: "\(runtime) minute")
                    }
                    let formater = NumberFormatter()
                    formater.groupingSeparator = "."
                    formater.numberStyle = .decimal
                    self.detailMovie = detailMovieResponce
                    if let v = detailMovieResponce?.budget {
                        let formattedNumber = formater.string(from: NSNumber(value: v))
                        self.budgetLabel.text = "$\(formattedNumber!)"
                        if v == 0 {
                            self.stackViewBudget.arrangedSubviews.forEach({ (view) in
                                view.removeFromSuperview()
                            })
                        }
                        
                    }
                    if let a = detailMovieResponce?.revenue {
                        let formattedNumber = formater.string(from: NSNumber(value: a))
                        self.revenueLabel.text = "$\(formattedNumber!)"
                        if a < 100 {
                            self.stackViewRevenue.arrangedSubviews.forEach({ (view) in
                                view.removeFromSuperview()
                            })
                            
                        }
                    }
                    self.originalLanguageLabel.text = detailMovieResponce?.original_language
                    
                }
            })
        }
      
        // убрал large title на втором экране
        navigationItem.largeTitleDisplayMode = .never
        // чтоб открывалась картинка по нажатию
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            detailScreenImageMovies.isUserInteractionEnabled = true
            detailScreenImageMovies.addGestureRecognizer(tapGestureRecognizer)
        
        
        descriptionsLabel.text = movies.overview
        nameMoviesDetailScreen.text = movies.original_title
        if let image = movies.poster_path {
            if let imageURL = URL(string: "\("https://image.tmdb.org/t/p/w500")\(image)"), let imageView = detailScreenImageMovies {
                Nuke.loadImage(with: imageURL, into: imageView )
            }
        }
    
}
    // Ф-ция для картинки по нажатию , передаю данные на новый экран где картинка
    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
//        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "BigMovieOpenTap") as? OpenMoviesImageViewController
        self.navigationController?.pushViewController(controller!, animated: true)
        controller?.movies2 = self.movies
    }
}
