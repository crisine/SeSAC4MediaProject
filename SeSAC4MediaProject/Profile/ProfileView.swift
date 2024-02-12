//
//  ProfileView.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/12/24.
//

import UIKit
import SnapKit

final class ProfileView: BaseView {
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero)
        
        view.register(ProfileImageTableViewCell.self, forCellReuseIdentifier: "ProfileImageTableViewCell")
        view.register(ProfileItemTableViewCell.self, forCellReuseIdentifier: "ProfileItemTableViewCell")
        
        view.isScrollEnabled = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    

    override func configureHierarchy() {
        [tableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        
        tableView.snp.makeConstraints { make in
            make.verticalEdges.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        
    }
    
    override func configureView() {
        
        tableView.backgroundColor = .black
        
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
