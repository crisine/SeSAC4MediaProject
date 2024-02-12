//
//  BlackTextLabel.swift
//  SeSAC4Seflix
//
//  Created by Minho on 1/29/24.
//

import UIKit

class BlackTextLabel: UILabel {
    
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
        numberOfLines = 2
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 8
    }
}
