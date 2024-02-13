//
//  ProfileViewController.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/12/24.
//

import UIKit
import Kingfisher

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
            
            let url = URL(string: UserDefaults.standard.string(forKey: "profileImageUrl") ?? "")
            cell.profileImageView.kf.setImage(with: url)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didProfileImageTapped))
            
            cell.profileImageView.addGestureRecognizer(tapGesture)
            cell.profileImageView.isUserInteractionEnabled = true
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileItemTableViewCell", for: indexPath) as! ProfileItemTableViewCell
            
            let itemTitle = itemTitleList[rowNum - 1]
            
            cell.itemTitleLabel.text = itemTitle.rawValue
            cell.itemDetailLabel.text = ProfileModelManager.shared.getValue(title: itemTitle)
            
            // MARK: 저장된 정보가 없는 경우 placeholder 출력 필요
            // ->
            
            cell.itemModifyButton.tag = rowNum - 1
            cell.itemModifyButton.addTarget(self, action: #selector(didItemModifyButtonTapped), for: .touchUpInside)
            
            return cell
        }
    }
    
    @objc
    func didProfileImageTapped(sender: UIImageView) {
        print("프로필 이미지 눌림")
        let vc = ImageSearchViewController()
        
        vc.imageSpace = { urlString in
            print("이미지 링크 : \(urlString)")
            
            // MARK: Manager를 통하여 값을 관리하도록 추후 변경
            UserDefaults.standard.setValue(urlString, forKey: "profileImageUrl")
            self.mainView.tableView.reloadData()
        }
        
        present(vc, animated: true)
    }
    
    @objc
    func didItemModifyButtonTapped(sender: UIButton) {
        print("\(sender.tag) 번 프로필 아이템 버튼 눌림!")

        let vc = ProfileItemModifyViewController()

        // MARK: itemText는 사용자에게 저장되어 있는 실제 값을 불러오아야만 함
        let itemText = ProfileModelManager.shared.getValue(title: itemTitleList[sender.tag])
        vc.setViewLabelsText(titleText: itemTitleList[sender.tag].rawValue, itemText: itemText)
        
        vc.valueClosure = { value in
            print("수정 뷰로부터 넘겨받은 값 \(value)")
            
            ProfileModelManager.shared.saveValue(title: self.itemTitleList[sender.tag], value: value)
            
            self.mainView.tableView.reloadData()
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
}
