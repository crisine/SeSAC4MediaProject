//
//  FindTableViewCell.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/4/24.
//

import UIKit

class FindTableViewCell: UITableViewCell {
    
    let titleLabel = WhiteTextLabel()
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: configureCollectionViewLayout())
    

    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHirearchy()
        configureLayout()
        configureView()
    }
                                          
    func configureHirearchy() {
        [titleLabel, collectionView].forEach {
            contentView.addSubview($0)
        }
    }

    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(20)
            make.top.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(160)
            make.horizontalEdges.equalTo(contentView)
        }
    }
    
    func configureView() {
        backgroundColor = .black
        collectionView.backgroundColor = .clear
        titleLabel.backgroundColor = .clear
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 120, height: 160)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
