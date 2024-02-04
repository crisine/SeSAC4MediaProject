//
//  DetailViewController.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/5/24.
//

import UIKit
import Kingfisher

class DetailViewController: BaseViewController {
    
    let mainView = DetailView()
    var tvSeriesInfo: TVSeries
    
    init(tvSeriesInfo: TVSeries) {
        self.tvSeriesInfo = tvSeriesInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureView() {
        
        if let posterPath = tvSeriesInfo.poster_path {
            let url = "https://image.tmdb.org/t/p/w500\(posterPath)"
            mainView.posterImageView.kf.setImage(with: URL(string: url))
        }
        
        mainView.titleLabel.text = tvSeriesInfo.name
        mainView.ratingLabel.text = "★ " + String(tvSeriesInfo.vote_average)
        mainView.voteCountLabel.text = "(" + String(tvSeriesInfo.vote_count) + ")"
        mainView.overviewLabel.text = tvSeriesInfo.overview
    }
}
