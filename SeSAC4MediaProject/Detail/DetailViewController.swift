//
//  DetailViewController.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/5/24.
//

import UIKit
import Kingfisher

class DetailViewController: BaseViewController {
    
    private let mainView = DetailView()
    private var tvSeriesInfo: TVSeries
    private var similarTVSeriesList: [TVSeries] = []
    private var youtubeKey: String?
    
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
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        TMDBAPIManager.shared.request(type: TVSeriesModel.self, api: TMDBTVAPI.similar(seriesID: String(tvSeriesInfo.id))) { tvSeriesModel in
            self.similarTVSeriesList = tvSeriesModel.results
        }
    }
    
    override func configureView() {
        mainView.tableView.backgroundColor = .black
    }
}

extension DetailViewController {
    
    @objc
    private func didYoutubeButtonTapped() {
        let vc = YoutubeWebViewController()
        
        present(vc, animated: true)
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let rowNum = indexPath.row
        
        switch rowNum {
        case 0:
            return UIScreen.main.bounds.height
        case 1:
            return 200
        default:
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowNum = indexPath.row
        
        switch rowNum {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVSeriesInfoTableViewCell", for: indexPath) as! TVSeriesInfoTableViewCell
            
            let url = "https://image.tmdb.org/t/p/w500\(tvSeriesInfo.poster_path ?? "")"
            cell.posterImageView.kf.setImage(with: URL(string: url), placeholder: UIImage(systemName: "star.fill"))
            
            cell.titleLabel.text = tvSeriesInfo.name
            cell.ratingLabel.text = "★ " + String(tvSeriesInfo.vote_average)
            cell.voteCountLabel.text = "(" + String(tvSeriesInfo.vote_count) + ")"
            cell.overviewLabel.text = tvSeriesInfo.overview
            
            TMDBAPIManager.shared.request(type: VideoModel.self, api: TMDBTVAPI.videos(seriesID: String(tvSeriesInfo.id))) { videoModel in
            
                print("videoModel: \(videoModel)")
                print("results: \(videoModel.results)")
                self.youtubeKey = videoModel.results.first?.key
                
                UserDefaults.standard.setValue(self.youtubeKey, forKey: "youtubeKey")
                
                // 클로저 밖에서 아래 처리를 하는 경우 비동기로 인해 키가 있어도 버튼이 안 보일 수 있음
                if self.youtubeKey == nil {
                    cell.youtubeButton.isEnabled = false
                } else {
                    cell.youtubeButton.isEnabled = true
                }
            }
            
            cell.youtubeButton.addTarget(self, action: #selector(didYoutubeButtonTapped), for: .touchUpInside)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FindTableViewCell", for: indexPath) as! FindTableViewCell
            
            cell.selectionStyle = .none
            
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            
            cell.collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: "PosterCollectionViewCell")
            
            cell.collectionView.reloadData()
            cell.titleLabel.text = "similar tv series"
            
            return cell
        default:
            return UITableViewCell()
        }
    }

}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarTVSeriesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCollectionViewCell", for: indexPath) as! PosterCollectionViewCell
        
        let posterPath = similarTVSeriesList[indexPath.row].poster_path
        
        if let posterPath {
            let url = "https://image.tmdb.org/t/p/w500\(posterPath)"
            cell.posterImageView.kf.setImage(with: URL(string: url), placeholder: UIImage(systemName: "star.fill"))
        } else {
            cell.posterImageView.image = UIImage(systemName: "star.fill")
        }
        
        return cell
    }
    
    
}
