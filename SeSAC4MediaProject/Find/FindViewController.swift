//
//  FindViewController.swift
//  SeSAC4Seflix
//
//  Created by Minho on 1/31/24.
//

import UIKit
import SnapKit
import Kingfisher

class FindViewController: BaseViewController {

    let mainView = FindView()
    
    var tvSeriesLists: [[TVSeries]] = [[], [], [], []]
    var tvSeriesTableViewTitles: [String] = ["airing today", "trending series", "top rated series", "popular series"]
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.searchBar.delegate = self
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        let group = DispatchGroup()
        
        group.enter()
//        TMDBAPIManager.shared.request(type: TVSeriesModel.self, api: TMDBTVAPI.airing) { tvSeries in
//            self.tvSeriesLists[0] = tvSeries.results
//            group.leave()
//        }
        
        TMDBSessionManager.shared.fetchTVSeries(api: .trending, query: ["language": "ko-KR"]) { tvSeries, error in
            if let tvSeries {
                self.tvSeriesLists[0] = tvSeries.results
            } else {
                dump(error)
            }
            group.leave()
        }
        
        group.enter()
        TMDBAPIManager.shared.request(type: TVSeriesModel.self, api: TMDBTVAPI.trending) { tvSeries in
            self.tvSeriesLists[1] = tvSeries.results
            group.leave()
        }
        
        group.enter()
        TMDBAPIManager.shared.request(type: TVSeriesModel.self, api: TMDBTVAPI.topRated) { tvSeries in
            self.tvSeriesLists[2] = tvSeries.results
            group.leave()
        }
        
        group.enter()
        TMDBAPIManager.shared.request(type: TVSeriesModel.self, api: TMDBTVAPI.popular) { tvSeries in
            self.tvSeriesLists[3] = tvSeries.results
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.mainView.reloadData()
        }
    }

    override func configureView() {
        super.configureView()
        navigationItem.title = "메인 화면"
    }
}

extension FindViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let keyword = searchBar.text {
            TMDBAPIManager.shared.request(type: TVSeriesModel.self, api: TMDBTVAPI.search(query: keyword)) { tvSeriesList in
                
                // MARK: TV드라마 정보가 List로 들어오지만 일단 1개만 갖고 가는것으로 함.
                if let tvSeriesInfo = tvSeriesList.results.first {
                    
                    self.navigationController?.pushViewController(DetailViewController(tvSeriesInfo: tvSeriesInfo), animated: true)
                }
            }
        }
        
    }
}

extension FindViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowIndex = indexPath.row
        
        if rowIndex == 0 {
            return UIScreen.main.bounds.height / 1.5
        } else {
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvSeriesLists.count // airing, trending, topRated, popular
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowIndex = indexPath.row
    
        if rowIndex == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FindMainTableViewCell", for: indexPath) as! FindMainTableViewCell
            
            cell.selectionStyle = .none
            
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            
            cell.collectionView.register(FindCollectionViewCell.self, forCellWithReuseIdentifier: "FindCollectionViewCell")
            
            cell.collectionView.tag = rowIndex
            
            cell.collectionView.reloadData()
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FindTableViewCell", for: indexPath) as! FindTableViewCell
            
            cell.selectionStyle = .none
            
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            
            cell.collectionView.register(FindCollectionViewCell.self, forCellWithReuseIdentifier: "FindCollectionViewCell")
            
            cell.collectionView.tag = rowIndex
            cell.titleLabel.text = tvSeriesTableViewTitles[rowIndex]
            
            cell.collectionView.reloadData()
            
            return cell
        }
    }

}


extension FindViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let rowNum = collectionView.tag
        
        print("tvSeriesLists[\(rowNum)].count : \(tvSeriesLists[rowNum].count)")
        return tvSeriesLists[rowNum].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FindCollectionViewCell", for: indexPath) as! FindCollectionViewCell
        
        let rowNum = collectionView.tag
        let item = tvSeriesLists[rowNum][indexPath.item]
        
        if let poster = item.poster_path {

            let url = "https://image.tmdb.org/t/p/w500\(poster)" // poster = 포스터, backdrop = 백드롭
            cell.posterImageView.kf.setImage(with: URL(string: url), placeholder: UIImage(systemName: "star.fill"))
        } else {
            cell.posterImageView.image = UIImage(systemName: "star.fill")
        }
    
        
        return cell
    }
    
}
