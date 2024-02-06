//
//  TVSeriesInfoTableViewCell.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/7/24.
//

import UIKit

class TVSeriesInfoTableViewCell: UITableViewCell {
    
    let posterImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    let titleLabel = WhiteTextLabel()
    let ratingLabel = WhiteTextLabel()
    let voteCountLabel = WhiteTextLabel()
    let overviewLabel = WhiteTextLabel()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHirearchy()
        configureLayout()
        configureView()
    }
    
    func configureHirearchy() {
        [posterImageView, titleLabel, ratingLabel, voteCountLabel, overviewLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureLayout() {
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(8)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(UIScreen.main.bounds.width * 1.4)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(contentView)
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
            make.trailing.equalTo(contentView)
            make.height.equalTo(ratingLabel.snp.height)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp.bottom)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(120)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .black
        
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 8
        
        titleLabel.font = .boldSystemFont(ofSize: 24)
        ratingLabel.font = .systemFont(ofSize: 14)
        voteCountLabel.font = .systemFont(ofSize: 14)
        
        overviewLabel.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
