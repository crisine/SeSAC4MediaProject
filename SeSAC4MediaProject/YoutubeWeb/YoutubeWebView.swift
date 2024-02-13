//
//  YoutubeWebView.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/14/24.
//

import UIKit
import WebKit
import SnapKit

final class YoutubeWebView: BaseView {
    
    let webView = WKWebView()
    
    override func configureHierarchy() {
        self.addSubview(webView)
    }
    
    override func configureLayout() {
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
