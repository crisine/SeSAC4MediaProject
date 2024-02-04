//
//  WhiteTextLabel.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/5/24.
//

import UIKit

class WhiteTextLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init(coder: NSCoder) {
        print("required init called")
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.font = .boldSystemFont(ofSize: 15)
        self.textAlignment = .left
        textColor = .white
        numberOfLines = 2
        backgroundColor = .clear
        clipsToBounds = true
        layer.cornerRadius = 8
    }
}
