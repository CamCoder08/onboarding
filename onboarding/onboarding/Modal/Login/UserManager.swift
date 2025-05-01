//
//  UserManager.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import Foundation

class UserManager {
    static let shared = UserManager()

    private init() {}

    func saveUser(user: UserModel) {
        // UserDefaults에 개별 속성 저장하는 코드 작성 예정
    }

    func loadUser(id: String) -> UserModel? {
        // 저장된 사용자 불러오는 코드 작성 예정
        return nil
    }
}


