//
//  RegistrationManager.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import Foundation

// 등록된 킥보드 정보를 UserDefaults에 저장하고 불러오는 기능 담당
// 등록하기 번튼을 누르먄 받은 정보를 킥보드 정보를 저장하고
// 지도에게 알려주기
// 세이브..
class RegistrationManager {
    
    static let shared = RegistrationManager()
    private init() {}
    
    private let registrationKey = "registrationList"
    
    func saveDeviceInfo(deviceId: String, address: String, date: String) {
        
        var registrations = loadRegistrations()
        
        let newRegistration: [String: Any] = [
            "deviceId": deviceId,
            "address": address,
            "date": date
        ]
        
        registrations.append(newRegistration)
        UserDefaults.standard.set(registrations, forKey: registrationKey)
    }
    
    func loadRegistrations() -> [[String: Any]] {
        return UserDefaults.standard.array(forKey: registrationKey) as? [[String: Any]] ?? []
    }

}

