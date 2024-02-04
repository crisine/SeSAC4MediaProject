//
//  FindCollectionViewSell.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/4/24.
//

import UIKit
import SnapKit

class FindCollectionViewCell: UICollectionViewCell {
    
    let posterImageView = PosterImageView(frame: .zero)
    
    // 코드를 사용한 경우의 init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHirearchy()
        configureLayout()
        configureView()
    }
    
    func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
    }
    
    func configureHirearchy() {
        [posterImageView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureView() {
        posterImageView.image = UIImage(systemName: "person")
    }
    
    
    // 코드 init 만을 호출할 수는 없고 이쪽도 반드시 구현해야 함
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
