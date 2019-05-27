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
//import AVKit
//import AVFoundation


class SecondViewController: UIViewController, UIScrollViewDelegate{

    
    @IBOutlet private weak var originalLanguageLabel: UILabel!
    @IBOutlet private weak var runtimeLabel: UILabel!
    @IBOutlet private weak var budgetLabel: UILabel!
    @IBOutlet private weak var revenueLabel: UILabel!
    @IBOutlet private weak var descriptionsLabel: UILabel!
    @IBOutlet private weak var scrollVIewOutlet: UIScrollView!
    @IBOutlet private weak var detailScreenImageMovies: UIImageView!
    @IBOutlet private weak var nameMoviesDetailScreen: UILabel!
    
    @IBOutlet weak var showImagesButton: UIButton!
    @IBOutlet weak var playVideoButtonSettingsBorderColor: UIButton!
    //    var detailMovies = DetailMovieResponce!
    var detailMovie: DetailMovieResponce!
    var movies: Movie!
    private var detailManager = MoviesAPIManager()
    private let url = "https://api.themoviedb.org/3/movie/458156?api_key=4cb1eeab94f45affe2536f2c684a5c9e&append_to_response=videos"
    
    
    
    @IBAction func playVideoButton(_ sender: Any) {
//        let url1 = URL(string: "\("http://youtube.com/watch?v=")\(viedeos.first)")
        

    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideoButtonSettingsBorderColor.backgroundColor = .clear
        playVideoButtonSettingsBorderColor.layer.borderWidth = 0.5
        playVideoButtonSettingsBorderColor.layer.borderColor = UIColor.gray.cgColor
        
        showImagesButton.backgroundColor = .clear
        showImagesButton.layer.borderWidth = 0.5
        showImagesButton.layer.borderColor = UIColor.gray.cgColor
        
       

        detailManager.detailGetMovie(urlString: url, completion: { detailMovieResponce in
             DispatchQueue.main.async {
                if let v = detailMovieResponce?.budget {
                    self.budgetLabel.text = ("$\(v)")
            
                }
                if let a = detailMovieResponce?.revenue {
                    self.revenueLabel.text = ("$\(Float(a))")
                }
                self.originalLanguageLabel.text = detailMovieResponce?.original_language
                
                
               
            }
        })
        
     
       
    
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
