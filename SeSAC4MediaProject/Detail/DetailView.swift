//
//  DetailView.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/5/24.
//

import UIKit

class DetailView: BaseView {
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero)
        
        view.register(TVSeriesInfoTableViewCell.self, forCellReuseIdentifier: "TVSeriesInfoTableViewCell")
        view.register(FindTableViewCell.self, forCellReuseIdentifier: "FindTableViewCell")
        
        return view
    }()
    
    override func configureHierarchy() {
        self.addSubview(tableView)
    }
    
    override func configureLayout() {

        tableView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        self.backgroundColor = .black
    }
}
