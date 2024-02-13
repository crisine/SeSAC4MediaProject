//
//  ImageSearchCollectionViewCell.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/14/24.
//

import UIKit
import SnapKit

final class ImageSearchCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView(frame: .zero)
    
    // 코드를 사용한 경우의 init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHirearchy()
        configureLayout()
        configureView()
    }
    
    func configureHirearchy() {
        addSubview(imageView)
    }
    
    func configureLayout() {
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    func configureView() {
        
    }
    
    
    // 코드 init 만을 호출할 수는 없고 이쪽도 반드시 구현해야 함
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
