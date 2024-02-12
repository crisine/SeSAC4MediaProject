//
//  ProfileViewController.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/12/24.
//

import UIKit

enum ProfileItemTitle: String, CaseIterable {
    case realname = "이름"
    case nickname = "사용자 이름"
}

final class ProfileViewController: BaseViewController {
    
    private let mainView = ProfileView()
    private let itemTitleList = ProfileItemTitle.allCases
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    override func configureView() {
        super.configureView()
        
        navigationItem.title = "프로필"
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let rowNum = indexPath.row
        
        switch rowNum {
        case 0:
            return 140
        default:
            return 48
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemTitleList.count + 1 // MARK: 프로필 이미지 설정 셀 + item 개수
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowNum = indexPath.row
        
        switch rowNum {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileImageTableViewCell", for: indexPath) as! ProfileImageTableViewCell
            
            // MARK: 프로필 이미지 설정
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileItemTableViewCell", for: indexPath) as! ProfileItemTableViewCell
            
            cell.itemTitleLabel.text = itemTitleList[rowNum - 1].rawValue
//            cell.itemDetailLabel.text =
//          MARK: 알맞은 유저 정보를 ProfileModelManager 로부터 불러오기
//          menu의 case를 manager로 넘겨서 정보를 가져오는 것도 하나의 방법일수도 있을 것으로 보임.
            
            return cell
        }
    }
}
