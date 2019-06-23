//
//  WebViewController.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 30/05/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit
import WebKit


class WebViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    private var webView: WKWebView!
    var webViewVideo: Video!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        if let key = webViewVideo.key{
            let myURL = URL(string:"http://youtube.com/watch?v=\(key)")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
            
        }
        webView.isHidden = true
        activityIndicator.startAnimating()
        activityIndicator.color = .gray
        webView.navigationDelegate = self 
        
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        webView.isHidden = false
        activityIndicator.stopAnimating()
    }

}
