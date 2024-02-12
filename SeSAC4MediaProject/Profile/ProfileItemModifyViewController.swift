//
//  ProfileItemModifyViewController.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/13/24.
//

import UIKit

final class ProfileItemModifyViewController: BaseViewController {
    
    private let mainView = ProfileItemModifyView()
    private var saveItemDetailButton: UIBarButtonItem?
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveItemDetailButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(didSaveItemDetailButtonTapped))
        
        configureView()
    }
    
    override func configureView() {
        mainView.textField.addTarget(self, action: #selector(didTextFieldValueChanged), for: .editingChanged)
        
        navigationItem.rightBarButtonItem = saveItemDetailButton
    }

    @objc
    private func didTextFieldValueChanged(sender: UITextField) {
        
        // MARK: 이후 여기서 Valid한 내용 검사 로직을 포함할 것
        // MARK: MenuItem Case에 따른 검사 로직이 필요함. (이 뷰컨은 공통 뷰컨이라)
        if let text = sender.text {
            
            guard !text.isEmpty else {
                saveItemDetailButton?.isEnabled = false
                return
            }
            saveItemDetailButton?.isEnabled = true
            
        } else {
            saveItemDetailButton?.isEnabled = false
        }
    }
    
    @objc
    private func didSaveItemDetailButtonTapped() {
        // MARK: UserDefaults나 DB에 저장, 혹은 네트워크로 전송하는 과정 추가
        navigationController?.popViewController(animated: true)
    }

    public func setViewLabelsText(titleText: String, itemText: String) {
        mainView.textFieldTitleLabel.text = titleText
        mainView.textField.text = itemText
        
        navigationItem.title = titleText
    }
}
