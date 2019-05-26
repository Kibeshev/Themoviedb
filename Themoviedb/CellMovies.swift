//
//  CellMovies.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 08/05/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit
import Nuke

class CellMovies: UITableViewCell {
    
    @IBOutlet private weak var imageMovies: UIImageView!
    @IBOutlet private weak var showImage: UIImageView!
    @IBOutlet private weak var labelDescriptions: UILabel!
    @IBOutlet private weak var labelTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(movie: Movie) {
        labelTitle.text = movie.original_title
        labelDescriptions.text = movie.overview
        if let image = movie.poster_path  {
            if let imageURL = URL(string: "\("https://image.tmdb.org/t/p/w500")\(image)") {
                Nuke.loadImage(with: imageURL, into: imageMovies)
            }
        }
    }

}
