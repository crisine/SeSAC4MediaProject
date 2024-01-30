//
//  MediaViewController.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 1/31/24.
//

import UIKit
import SnapKit
import Kingfisher

class MediaViewController: UIViewController {

    lazy var collectionView = UICollectionView(frame: .zero,
    collectionViewLayout: configureCollectionViewLayout())
    
    let tableView = UITableView()
    
    var titleMovieList: [Movie] = [] // 상단 컬렉션 뷰
    
    var trendingMovieList: [Movie] = []
    var topRatedMovieList: [Movie] = []
    var popularMovieList: [Movie] = []
    
    var titleList: [String] = ["Trending Movies", "Top Rated Movies", "Popular Movies"] // 테이블뷰셀의 타이틀 레이블
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()
        configureView()
        
        TMDBAPIManager.shared.fetchAPIMovie(apiType: .upcoming) { movie in
            self.titleMovieList = movie
            self.collectionView.reloadData()
            self.tableView.reloadData()
        }
        
        TMDBAPIManager.shared.fetchAPIMovie(apiType: .trending) { movie in
            self.trendingMovieList = movie
            self.tableView.reloadData()
        }
        
        TMDBAPIManager.shared.fetchAPIMovie(apiType: .topRated) { movie in
            self.topRatedMovieList = movie
            self.tableView.reloadData()
        }
        
        TMDBAPIManager.shared.fetchAPIMovie(apiType: .popular) { movie in
            self.popularMovieList = movie
            self.tableView.reloadData()
        }
    }
    
    func configureHierarchy() {
        [collectionView, tableView].forEach {
            self.view.addSubview($0)
        }
    }
    
    func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MediaCollectionViewCell.self, forCellWithReuseIdentifier: "Media")
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 200
        tableView.register(MediaTableViewCell.self, forCellReuseIdentifier: "MediaTableViewCell")
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        return layout
    }

}

extension MediaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.collectionView == collectionView {
            return titleMovieList.count
        } else {
            switch collectionView.tag {
            case 0:
                return trendingMovieList.count
            case 1:
                return topRatedMovieList.count
            case 2:
                return popularMovieList.count
            default:
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Media", for: indexPath) as! MediaCollectionViewCell
        
        var imageUrl: String?
        
        if self.collectionView == collectionView {
            imageUrl = titleMovieList[indexPath.row].poster_path
        } else {
            switch collectionView.tag {
            case 0:
                imageUrl = trendingMovieList[indexPath.row].poster_path
            case 1:
                imageUrl = topRatedMovieList[indexPath.row].poster_path
            case 2:
                imageUrl = popularMovieList[indexPath.row].poster_path
            default:
                return cell
            }
        }

        if let imageUrl {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(imageUrl)")
            cell.posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "star.fill"))
        } else {
            cell.posterImageView.image = UIImage(systemName: "xmark")
        }
        
        return cell
    }
}

extension MediaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell", for: indexPath) as! MediaTableViewCell
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(MediaCollectionViewCell.self, forCellWithReuseIdentifier: "Media")
        
        cell.collectionView.tag = indexPath.row
        
        cell.titleLabel.text = titleList[indexPath.row]
        cell.collectionView.reloadData()
        
        return cell
    }

}
