//
//  TelevisionViewController.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 1/31/24.
//

import UIKit
import Kingfisher

class TelevisionViewController: BaseViewController {

    let movieId = 96102
    let titleList = ["배우 캐스팅 정보", "비슷한 드라마 추천"]
    
    var tvSeriesInfo: Movie?
    var similarMovies: [Movie] = []
    var castingInfo: CastModel?
    
    let imageView: UIImageView = {
        let view = UIImageView()
        
        view.backgroundColor = .red
        
        return view
    }()
    
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero,
    collectionViewLayout: configureCollectionViewLayout())
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        
        view.delegate = self
        view.dataSource = self
        view.rowHeight = 200
        view.register(MediaTableViewCell.self, forCellReuseIdentifier: "MediaTableViewCell")
        view.backgroundColor = .gray
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let group = DispatchGroup()
        
        group.enter()
        TMDBAPIManager.shared.fetchMovieDetail(movieId: movieId) { movie in
            self.tvSeriesInfo = movie
            
            let url = "https://image.tmdb.org/t/p/w500\(self.tvSeriesInfo?.poster_path ?? "")"
            print("url: \(url)")
            
            self.imageView.kf.setImage(with: URL(string: url), placeholder: UIImage(systemName: "xmark"))
            
            group.leave()
        }
        
        // 비슷한 드라마 추천, 캐스트 정보 불러오기
        group.enter()
        TMDBAPIManager.shared.fetchSimilarMovies(movieId: movieId) { movies in
            self.similarMovies = movies
            print("비슷한 영화 정보 로드 완료 : ", self.similarMovies.count)
            group.leave()
        }
        
        group.enter()
        TMDBAPIManager.shared.fetchCastInfo(movieId: movieId) { castModel in
            self.castingInfo = castModel
            print("캐스팅 정보 로드 완료 : ", self.castingInfo?.cast.count ?? 0)
            group.leave()
        }
        
        
        group.notify(queue: .main) {
            print("테이블 뷰 및 컬렉션 뷰 재설정")
            self.tableView.reloadData()
            self.collectionView.reloadData()
        }
    }

    override func configureHierarchy() {
        [imageView, tableView].forEach {
            view.addSubview($0)
        }
        
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(600)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 160)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        return layout
    }
}

extension TelevisionViewController: UITableViewDelegate, UITableViewDataSource {
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("테이블뷰 크기 반환")
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell", for: indexPath) as! MediaTableViewCell
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(MediaCollectionViewCell.self, forCellWithReuseIdentifier: "Media")

        cell.titleLabel.text = titleList[indexPath.row]
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()
        
        return cell
    }

}

extension TelevisionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("컬렉션 뷰 크기 반환")
        switch collectionView.tag {
        case 0:
            print("castingInfo.case.count : ", castingInfo?.cast.count ?? 0)
            return castingInfo?.cast.count ?? 0
        case 1:
            print("similarMovies.count : ", similarMovies.count)
            return similarMovies.count
        default:
            print("default 호출되어버림")
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("컬렉션 뷰 내용 설정")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Media", for: indexPath) as! MediaCollectionViewCell
        
        switch collectionView.tag {
        case 0:
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(castingInfo?.cast[indexPath.row].profilePath ?? "")")
            cell.posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "xmark"))
            cell.titleLabel.text = castingInfo?.cast[indexPath.row].originalName
            cell.titleLabel.textAlignment = .center
        case 1:
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(similarMovies[indexPath.row].poster_path ?? "")")
            cell.posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "xmark"))
        default:
            return cell
        }
        
        return cell
    }
    
}
