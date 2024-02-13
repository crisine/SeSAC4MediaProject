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
    
    var searchedImageList: [NaverImage] = []
    var start: Int = 1
    
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
        
        guard let query = searchBar.text else { return }
        
        NaverAPIManager.shared.fetchImage(query: query, start: start) { naverImageModel, error in

            if let naverImageModel {
                guard naverImageModel.items.count != 0 else {
                    print("검색된 이미지 없음") // MARK: Alert로 띄워야 함
                    self.searchedImageList.removeAll()
                    return
                }
                self.searchedImageList = naverImageModel.items
                self.mainView.collectionView.reloadData()
                self.mainView.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
            } else {
                print("이미지 검색 통신 실패")
                dump(error)
            }
            
        }
    }
}

extension ImageSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedImageList.count // MARK: 네트워크 통신 후 받아온 이미지의 리스트 .count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSearchCollectionViewCell", for: indexPath) as! ImageSearchCollectionViewCell
        let index = indexPath.row
        let urlString = searchedImageList[index].thumbnail
        
        print("이미지 세팅중")
        cell.imageView.kf.setImage(with: URL(string: urlString))
        cell.imageView.contentMode = .scaleAspectFill
        
        return cell
    }
    
    
}
