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
    
    private var searchedImageList: [NaverImage] = [] {
        didSet {
            mainView.collectionView.reloadData()
        }
    }
    
    private var start: Int = 1
    
    var imageSpace: ((String) -> Void)?

    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.searchBar.delegate = self
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.prefetchDataSource = self
        
        mainView.collectionView.register(ImageSearchCollectionViewCell.self, forCellWithReuseIdentifier: "ImageSearchCollectionViewCell")
        
        mainView.collectionView.collectionViewLayout = mainView.configureCollectionViewLayout()
    }
    
    override func configureHierarchy() {
        
    }
    
    override func configureLayout() {
    
    }
    
    override func configureView() {
        
    }
    
    private func fetchImages(query: String, start: Int) {
        NaverAPIManager.shared.fetchImage(query: query, start: start) { naverImageModel, error in

            if let naverImageModel {
                guard naverImageModel.items.count != 0 else {
                    print("검색된 이미지 없음") // MARK: Alert로 띄워야 함
                    self.searchedImageList.removeAll()
                    return
                }
                
                if start == 1 {
                    self.searchedImageList = naverImageModel.items
                    self.mainView.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
                } else {
                    self.searchedImageList.append(contentsOf: naverImageModel.items)
                }
                
            } else {
                print("이미지 검색 통신 실패")
                dump(error)
            }
            
        }
    }
}

extension ImageSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        print("검색을 위한 통신 시작")
        
        start = 1
        guard let query = searchBar.text else { return }
        
        fetchImages(query: query, start: start)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let index = indexPath.row
        let alert = UIAlertController(title: "프로필 사진", message: "선택된 이미지로 설정하시겠습니까?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .destructive) { _ in
            self.imageSpace!(self.searchedImageList[index].link)
            self.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
}

extension ImageSearchViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {

            if searchedImageList.count - 8 == indexPath.row {

                start += 30
                
                // MARK: 이미지 검색 창에 텍스트를 수정하고 아래로 스크롤하는 경우 문제 발생 여지 있음
                // 이 부분을 보완해야 함.
                // Apple 검색 -> 검색 결과 표시됨 -> App로 지웠으나 검색은 안 누름 -> 아래로 스크롤
                // -> Prefetch 호출 -> App 에 대한 이미지 검색 결과 반환의 여지가 있음.
                guard let query = mainView.searchBar.text else { return }
                
                fetchImages(query: query, start: start)
            }
        }
    }
    
}
