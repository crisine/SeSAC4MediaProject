//
//  PosterImageView.swift
//  SeSAC4Seflix
//
//  Created by Minho on 1/29/24.
//

import UIKit

// extension imageView vs class
class PosterImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        contentMode = .scaleAspectFill
        layer.cornerRadius = 12
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
