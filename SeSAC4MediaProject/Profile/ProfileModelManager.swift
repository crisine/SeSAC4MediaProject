//
//  ProfileModelManager.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/12/24.
//

import Foundation

final class ProfileModelManager {
    
    static let shared = ProfileModelManager()
    private var userProfile: ProfileModel
    
    private init() {
        let realName = UserDefaults.standard.string(forKey: ProfileItemTitle.realname.rawValue)
        let nickName = UserDefaults.standard.string(forKey: ProfileItemTitle.nickname.rawValue)
        
        // MARK: ProfileItemTitle 의 case를 사용하여 저장/로드하는게 여기서 문제가 되게 됨. 해결책 필요
        let imageUrlString = UserDefaults.standard.string(forKey: "profileImageUrl")
        
        userProfile = ProfileModel(realName: realName ?? "", nickName: nickName ?? "", imageUrlString: imageUrlString ?? "")
    }
    
    // MARK: throws를 통하여 정해진 enum case 의 error를 반환하도록 고려 필요
    public func saveValue(title: ProfileItemTitle, value: String) {
        switch title {
        case .realname:
            userProfile.realName = value
        case .nickname:
            userProfile.nickName = value
        }
        
        UserDefaults.standard.setValue(value, forKey: title.rawValue)
    }
    
    public func getValue(title: ProfileItemTitle) -> String {
        switch title {
        case .realname:
            return userProfile.realName
        case .nickname:
            return userProfile.nickName
        }
    }
}
