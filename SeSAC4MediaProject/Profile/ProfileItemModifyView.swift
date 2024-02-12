//
//  ProfileItemModifyView.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/13/24.
//

import UIKit
import SnapKit

final class ProfileItemModifyView: BaseView {
    
    let textFieldTitleLabel: UILabel = {
        let view = UILabel()
        
        view.textColor = .gray
        view.font = .systemFont(ofSize: 14)
        
        return view
    }()
    let textField: UITextField = {
        let view = UITextField()
        
        view.font = .systemFont(ofSize: 16)
        view.clearButtonMode = .always
        view.textColor = .white
        view.backgroundColor = .black
        view.setClearButton(with: UIImage(systemName: "xmark.circle.fill")!,tintColor: .gray, mode: .whileEditing)
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureHierarchy() {
        
        [textFieldTitleLabel, textField].forEach {
            self.addSubview($0)
        }
        
    }
    
    override func configureLayout() {
        
        textFieldTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(16)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(textFieldTitleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(24)
        }
        
    }
    
    override func configureView() {
        self.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
