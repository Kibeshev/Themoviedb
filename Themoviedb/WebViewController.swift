//
//  WebViewController.swift
//  Themoviedb
//
//  Created by Кирилл Кибешев on 30/05/2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit
import WebKit


class WebViewController: UIViewController {
    
    //MARK: - Subviews
    
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Priperties
    
    private var webView: WKWebView!
    var webViewVideo: Video!

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
        loadUrl()
    }
    
    // MARK: - Private methods
    
    private func configureWebView(){
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        webView.isHidden = true
        webView.navigationDelegate = self
        activityIndicator.color = .gray
    }
    
    private func loadUrl(){
        if let key = webViewVideo.key {
            let myURL = URL(string:"http://youtube.com/watch?v=\(key)")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
            activityIndicator.startAnimating()
        }
    }
}

//MARK:-WKNavigationDelegate

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        webView.isHidden = false
        activityIndicator.stopAnimating()
    }
}
