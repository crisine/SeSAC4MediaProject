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
        // MARK: UserDefaults를 통해 저장하고, 나중에는 DB나 네트워크로 변경
        let realName = UserDefaults.standard.string(forKey: ProfileItemTitle.realname.rawValue)
        let nickName = UserDefaults.standard.string(forKey: ProfileItemTitle.nickname.rawValue)
        
        userProfile = ProfileModel(realName: realName ?? "", nickName: nickName ?? "")
    }
    
    // MARK: throws를 통하여 정해진 enum case 의 error를 반환
    public func saveValue(title: ProfileItemTitle, value: String) {
        switch title {
        case .realname:
            userProfile.realName = value
        case .nickname:
            userProfile.nickName = value
        }
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
