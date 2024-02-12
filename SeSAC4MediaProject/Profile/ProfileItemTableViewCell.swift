//
//  ProfileItemTableViewCell.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/12/24.
//

import UIKit
import SnapKit

final class ProfileItemTableViewCell: UITableViewCell {
    
    let itemTitleLabel: UILabel = {
        let view = UILabel()
        
        view.textColor = .white
        view.font = .systemFont(ofSize: 16)
        view.backgroundColor = .clear
        
        return view
    }()
    let itemDetailLabel: UILabel = {
    let view = UILabel()
    
    view.textColor = .white
    view.font = .systemFont(ofSize: 16)
    view.backgroundColor = .clear
    
    return view
}()
    let itemModifyButton: UIButton = {
        let view = UIButton(type: .custom)
        
        view.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        view.tintColor = .gray
        view.backgroundColor = .clear
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    
    private func configureHierarchy() {
        
        [itemTitleLabel, itemDetailLabel, itemModifyButton].forEach {
            contentView.addSubview($0)
        }
        
    }
    
    private func configureLayout() {
        
        itemTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.center)
            make.leading.equalTo(contentView.snp.leading).offset(8)
            make.width.equalTo(80)
        }
        
        itemDetailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.center)
            make.height.equalTo(24)
            make.leading.equalTo(itemTitleLabel.snp.trailing).offset(8)
            make.trailing.equalTo(itemModifyButton.snp.leading).offset(8)
        }
        
        itemModifyButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.center)
            make.trailing.equalTo(contentView.snp.trailing).offset(-8)
            make.width.height.equalTo(32)
        }
    }
    
    private func configureView() {
        
        self.selectionStyle = .none
        self.backgroundColor = .black
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
