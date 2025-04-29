//
//  UserManager.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import Foundation

struct User {
    let id: String
    let password: String
    let nickname: String
}

class UserManager {
    static let shared = UserManager()
    
    private init() {}
    
    private(set) var userList: [User] = [
        User(id: "testuser", password: "1234", nickname: "Tester")
    ]
    
    func registerUser(id: String, password: String, nickname: String) {
        let newUser = User(id: id, password: password, nickname: nickname)
        userList.append(newUser)
    }
    
    func isIDDuplicated(_ id: String) -> Bool {
        return userList.contains { $0.id == id }
    }
    
    func isNicknameDuplicated(_ nickname: String) -> Bool {
        return userList.contains { $0.nickname == nickname }
    }
}
