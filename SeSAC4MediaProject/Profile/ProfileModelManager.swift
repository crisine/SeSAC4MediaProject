//
//  ProfileModelManager.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/12/24.
//

final class ProfileModelManager {
    
    static let shared = ProfileModelManager()
    private var userProfile: ProfileModel
    
    private init() {
        // MARK: UserDefaults를 통해 저장하고, 나중에는 DB나 네트워크로 변경
        userProfile = ProfileModel(realName: "", nickName: "")
    }
    
    // MARK: throws를 통하여 정해진 enum case 의 error를 반환
    public func setRealName(realName: String) {
        userProfile.realName = realName
    }
    
    public func getRealName() -> String {
        return userProfile.realName
    }
    
    public func setNickName(nickName: String) {
        userProfile.nickName = nickName
    }
    
    public func getNickName() -> String {
        return userProfile.realName
    }
}
