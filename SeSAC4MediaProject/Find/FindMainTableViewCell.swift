//
//  FindMainTableViewCell.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/5/24.
//

import Foundation

import UIKit

class FindMainTableViewCell: UITableViewCell {
    
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: configureCollectionViewLayout())
    

    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHirearchy()
        configureLayout()
        configureView()
    }
                                          
    func configureHirearchy() {
        [collectionView].forEach {
            contentView.addSubview($0)
        }
    }

    func configureLayout() {
        
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.horizontalEdges.equalTo(contentView)
        }
    }
    
    func configureView() {
        backgroundColor = .clear
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 10, height: UIScreen.main.bounds.height / 1.5)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
