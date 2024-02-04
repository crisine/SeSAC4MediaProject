//
//  FindView.swift
//  SeSAC4Seflix
//
//  Created by Minho on 2/1/24.
//

import UIKit

class FindView: BaseView {
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        
        view.placeholder = "드라마를 검색해보세요"
        view.showsCancelButton = true
        view.barStyle = .black
        
        return view
    }() // viewDidLoad() 보다 클로저 구문이 먼저 실행됨!
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.register(FindTableViewCell.self, forCellReuseIdentifier: "FindTableViewCell")
        view.register(FindMainTableViewCell.self, forCellReuseIdentifier: "FindMainTableViewCell")
        
        return view
    }()
    
    override func configureHierarchy() {
        [searchBar, tableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
    }
    
    override func configureView() {
        tableView.backgroundColor = .black
    }
    
    func reloadData() {
        self.reloadInputViews()
        tableView.reloadData()
    }
}
