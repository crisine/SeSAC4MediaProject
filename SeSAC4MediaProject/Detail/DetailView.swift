//
//  DetailView.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/5/24.
//

import UIKit

class DetailView: BaseView {
    
    let posterImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    let titleLabel = WhiteTextLabel()
    let ratingLabel = WhiteTextLabel()
    let voteCountLabel = WhiteTextLabel()
    let overviewLabel = WhiteTextLabel()
    
    override func configureHierarchy() {
        [posterImageView, titleLabel, ratingLabel, voteCountLabel, overviewLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(8)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.width * 1.4)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(26)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(titleLabel)
            make.width.greaterThanOrEqualTo(24)
            make.height.equalTo(16)
        }
        
        voteCountLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp.top)
            make.leading.equalTo(ratingLabel.snp.trailing).offset(8)
            make.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(ratingLabel.snp.height)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp.bottom)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(80)
        }
    }
    
    override func configureView() {
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 8
        
        titleLabel.font = .boldSystemFont(ofSize: 24)
        ratingLabel.font = .systemFont(ofSize: 14)
        voteCountLabel.font = .systemFont(ofSize: 14)
        
        overviewLabel.numberOfLines = 0
    }
}
