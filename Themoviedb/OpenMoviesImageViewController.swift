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
    
    var isOn = false {
        didSet {
            updateUI()
        }
    }
    @IBOutlet weak var openImage: UIImageView!
    
    var movies2: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // убрал larde title
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        title = "Poster"
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        openImage?.isUserInteractionEnabled = true
        openImage?.addGestureRecognizer(tapGestureRecognizer)
        
        if let image = movies2.poster_path {
            if let imageURL = URL(string: "\("https://image.tmdb.org/t/p/w500")\(image)"), let imageView = openImage {
                Nuke.loadImage(with: imageURL, into: imageView )
            }
     
        
        
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
//    func tapHandler() {
//        if isNavigationHidden {
//        //показать
//            isNavigationHidden = false
//
//        } else {
//
//           // скрыть
//            isNavigationHidden = true
//        }
//    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        isOn = !isOn
//        let tappedImage = tapGestureRecognizer.view as! UIImageView
//        self.navigationItem.hidesBackButton = false

    }
    func updateUI(){
        if isOn{
            self.navigationController?.isNavigationBarHidden = true
            self.view.backgroundColor = .black
        } else {
            self.navigationController?.isNavigationBarHidden = false
            self.view.backgroundColor = .white

        }
    }
}
