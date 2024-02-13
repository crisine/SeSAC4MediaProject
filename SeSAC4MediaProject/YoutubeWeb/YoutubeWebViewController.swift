//
//  YoutubeWebViewController.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/14/24.
//

import UIKit

final class YoutubeWebViewController: BaseViewController {
    
    let youtubeKey = UserDefaults.standard.string(forKey: "youtubeKey")
    
    let mainView = YoutubeWebView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPage()
    }
    
    private func loadPage() {
        let url = URL(string: "http://www.youtube.com/watch?v=\(youtubeKey ?? "")")
        let requestURL = URLRequest(url: url!)
        
        mainView.webView.load(requestURL)
    }
}
