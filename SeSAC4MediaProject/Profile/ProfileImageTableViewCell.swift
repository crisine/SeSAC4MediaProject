//
//  ProfileImageTableViewCell.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/12/24.
//

import UIKit
import SnapKit

final class ProfileImageTableViewCell: UITableViewCell {
    
    let profileImageView: UIImageView = {
        let view = UIImageView()
        
        view.contentMode = .scaleAspectFill
        view.image = UIImage(systemName: "person")
        view.tintColor = .white
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        
        return view
    }()
    private let modifyProfileImageButton: UILabel = {
        let view = UILabel()
        
        view.text = "프로필 사진 수정"
        view.font = .boldSystemFont(ofSize: 16)
        view.backgroundColor = .clear
        view.textAlignment = .center
        view.textColor = .systemBlue
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    
    private func configureHierarchy() {
        
        [profileImageView, modifyProfileImageButton].forEach {
            contentView.addSubview($0)
        }
        
    }
    
    private func configureLayout() {
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(8)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
        modifyProfileImageButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(8)
            make.bottom.lessThanOrEqualTo(contentView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
        }
        
    }
    
    private func configureView() {
        
        self.selectionStyle = .none
        self.backgroundColor = .black
        
        profileImageView.layer.cornerRadius = 40 // MARK: width 가 아직 정해지지 않은 것 같아서 frame.width 하면 문제 발생
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
