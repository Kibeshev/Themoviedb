//
//  CellMovies.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 08/05/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit

class CellMovies: UITableViewCell {
    
    @IBOutlet weak var imageMovies: UIImageView!
    
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var labelDescriptions: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
