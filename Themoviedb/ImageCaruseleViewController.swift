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
    
    @IBOutlet weak var scrollImages: UIScrollView!
    
//    var detailMovie: DetailMovieResponse!
    private var detailManager = MoviesAPIManager()
    var movies: Movie!
    var apsectRatiio: Posters!
//    var getImages: DetailMovieResponse!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let moviesID = movies.id {
 
            detailManager.getMovieImages(id: moviesID, completion: { getImagesCaruseleResponce in
                DispatchQueue.main.async {

                    if let images = getImagesCaruseleResponce?.posters {
                        for i in 0..<images.count {
                            let xOrigin = UIApplication.shared.keyWindow!.bounds.width * CGFloat(i)
                            let imageCarousel = UIImageView()
                            imageCarousel.contentMode = .scaleAspectFit
                            imageCarousel.isUserInteractionEnabled = true
                            imageCarousel.frame = CGRect(x: xOrigin, y: 0, width: UIApplication.shared.keyWindow!.bounds.width, height: 240)
                            self.scrollImages.addSubview(imageCarousel)
                            if let urlStr = images[i].file_path {
                                if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(urlStr)") {
                                    Nuke.loadImage(with: imageURL, into: imageCarousel )
                                }
                            }
                        }
                        self.scrollImages.isPagingEnabled = true
                        self.scrollImages.contentSize = CGSize(width:
                            UIApplication.shared.keyWindow!.bounds.width * CGFloat(images.count), height: 240 )
                    }

                }
            })
        
    }
        
      
//        let view = UIView()
//        self.view.frame = CGRect(x: 10, y: 10, width: 200, height: 40)
//        self.view.addSubview(view)

        // Do any additional setup after loading the view.
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
