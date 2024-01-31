//
//  MediaCollectionViewCell.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 1/31/24.
//

import UIKit
import SnapKit

class MediaCollectionViewCell: UICollectionViewCell {
    
    let posterImageView = PosterImageView(frame: .zero)
    let titleLabel = BlackTextLabel()
    
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
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView)
            make.height.equalTo(20)
        }
    }
    
    func configureHirearchy() {
        [posterImageView, titleLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureView() {
        posterImageView.contentMode = .scaleAspectFill
    }
    
    
    // 코드 init 만을 호출할 수는 없고 이쪽도 반드시 구현해야 함
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
