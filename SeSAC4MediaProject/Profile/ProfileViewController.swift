//
//  ProfileViewController.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/12/24.
//

import UIKit

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
        navigationItem.backButtonTitle = ""
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
            
            cell.itemModifyButton.tag = rowNum - 1
            cell.itemModifyButton.addTarget(self, action: #selector(didItemModifyButtonTapped), for: .touchUpInside)
//            cell.itemDetailLabel.text =
//          MARK: 알맞은 유저 정보를 ProfileModelManager 로부터 불러오기
//          menu의 case를 manager로 넘겨서 정보를 가져오는 것도 하나의 방법일수도 있을 것으로 보임.
            
            return cell
        }
    }
    
    @objc
    func didItemModifyButtonTapped(sender: UIButton) {
        print("\(sender.tag) 번 프로필 아이템 버튼 눌림!")

        let vc = ProfileItemModifyViewController()

        // MARK: itemText는 사용자에게 저장되어 있는 실제 값을 불러오아야만 함
        vc.setViewLabelsText(titleText: itemTitleList[sender.tag].rawValue, itemText: "임시")
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
