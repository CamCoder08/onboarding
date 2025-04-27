//
//  KickboardManager.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import Foundation

class KickboardManager {
    static let shared = KickboardManager()
    
    private init() {}
    
    func saveKickboards(_ kickboards: [KickboardModel]) {
        // UserDefaults에 저장 예정
    }
    
    func loadKickboards() -> [KickboardModel] {
        // UserDefaults에서 불러오기 예정
        return []
    }
}
