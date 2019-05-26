//
//  SecondViewController.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 12/05/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit
import Nuke

class SecondViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet private weak var descriptionsLabel: UILabel!
    @IBOutlet private weak var scrollVIewOutlet: UIScrollView!
    @IBOutlet private weak var detailScreenImageMovies: UIImageView!
    @IBOutlet private weak var nameMoviesDetailScreen: UILabel!
    
    var movies: Movie!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
