//
//  UserManager.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import Foundation

class UserManager {
    static let shared = UserManager()
    
    private init() {
        loadUsers()
    }
    
    private let userListKey = "SavedUsers"
    private let loggedInUserIDKey = "LoggedInUserID"
    
    private(set) var userList: [UserModel] = []
    
    var currentUser: UserModel? {
        guard let id = UserDefaults.standard.string(forKey: loggedInUserIDKey) else { return nil }
        return userList.first(where: { $0.id == id })
    }
    
    //회원가입
    func registerUser(id: String, password: String, nickname: String) {
        let newUser = UserModel(id: id, password: password, nickname: nickname)
        userList.append(newUser)
        saveUsers()
    }
    
    // 로그인
    func login(id: String, password: String) -> LoginResult {
        loadUsers()
        guard let userModel = userList.first(where: { $0.id == id }) else {
            return .idNotFound
        }
        guard userModel.password == password else {
            return .wrongPassword
        }

        UserDefaults.standard.set(userModel.id, forKey: loggedInUserIDKey)
        UserDefaults.standard.set(userModel.id, forKey: "LastLoginID")         // 추가
        UserDefaults.standard.set(userModel.password, forKey: "LastLoginPassword") // 추가

        return .success(userModel)
    }

    
    // 로그아웃
    func logout() {
        UserDefaults.standard.removeObject(forKey: loggedInUserIDKey)
    }
    
    //중복체크
    func isIDDuplicated(_ id: String) -> Bool {
        return userList.contains { $0.id == id }
    }
    
    //닉네임 중복체크
    func isNicknameDuplicated(_ nickname: String) -> Bool {
        return userList.contains { $0.nickname == nickname }
    }
    
    // 저장 & 불러오기
        private func saveUsers() {
            if let data = try? JSONEncoder().encode(userList) {
                UserDefaults.standard.set(data, forKey: userListKey)
            }
        }
    
    private func loadUsers() {
        guard let data = UserDefaults.standard.data(forKey: userListKey),
              let savedUsers = try? JSONDecoder().decode([UserModel].self, from: data) else { return }
        self.userList = savedUsers
    }
    
}
enum LoginResult {
    case success(UserModel)
    case idNotFound
    case wrongPassword
}
