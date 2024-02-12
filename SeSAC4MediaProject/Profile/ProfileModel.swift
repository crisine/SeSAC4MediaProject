//
//  ProfileModel.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 2/12/24.
//

enum ProfileItemTitle: String, CaseIterable {
    case realname = "이름"
    case nickname = "사용자 이름"
}

final class ProfileModel {
    
    var realName: String
    var nickName: String
    
    init(realName: String, nickName: String) {
        self.realName = realName
        self.nickName = nickName
    }
    
}
