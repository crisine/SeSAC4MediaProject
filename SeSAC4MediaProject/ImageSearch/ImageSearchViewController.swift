//
//  ImageSearchViewController.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/14/24.
//

import Foundation
import Kingfisher
import UIKit

final class ImageSearchViewController: BaseViewController {
    
    private let mainView = ImageSearchView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.searchBar.delegate = self
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        mainView.collectionView.register(ImageSearchCollectionViewCell.self, forCellWithReuseIdentifier: "ImageSearchCollectionViewCell")
        
        mainView.collectionView.collectionViewLayout = mainView.configureCollectionViewLayout()
    }
    
    override func configureHierarchy() {
        
    }
    
    override func configureLayout() {
    
    }
    
    override func configureView() {
        
    }
    
    
    
}

extension ImageSearchViewController: UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("검색을 위한 통신 시작")
        
        // MARK: 검색 완료 후 collectionView ReloadData.
    }
}

extension ImageSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30 // MARK: 네트워크 통신 후 받아온 이미지의 리스트 .count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSearchCollectionViewCell", for: indexPath) as! ImageSearchCollectionViewCell
        
        print("이미지 세팅중")
        cell.imageView.image = UIImage(systemName: "star.fill")
        cell.imageView.backgroundColor = UIColor(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1), alpha: 1)
//        cell.backgroundColor = UIColor(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1), alpha: 1)
        cell.imageView.contentMode = .scaleAspectFill
        
        // cell.imageView -> 네트워크 통신 후 받아온 image 할당
        
        return cell
    }
    
    
}
