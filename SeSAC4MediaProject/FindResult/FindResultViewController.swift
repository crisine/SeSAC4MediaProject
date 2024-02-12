//
//  FindResultViewController.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/7/24.
//

import UIKit

class FindResultViewController: BaseViewController {
    
    let mainView = FindResultView()
    var tvSeriesList: [TVSeries] = []
    
    init(data: [TVSeries]) {
        self.tvSeriesList = data
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
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    override func configureView() {
        
    }
    
}

extension FindResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("tvSeriesListCount : \(tvSeriesList.count)")
        return tvSeriesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCollectionViewCell", for: indexPath) as! PosterCollectionViewCell
        
        if let posterPath = tvSeriesList[indexPath.row].poster_path {

            let url = "https://image.tmdb.org/t/p/w500\(posterPath)" // poster = 포스터, backdrop = 백드롭
            cell.posterImageView.kf.setImage(with: URL(string: url), placeholder: UIImage(systemName: "star.fill"))
        } else {
            cell.posterImageView.image = UIImage(systemName: "star.fill")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailViewController(tvSeriesInfo: tvSeriesList[indexPath.row]), animated: true)
    }
}
