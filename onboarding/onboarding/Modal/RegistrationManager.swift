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

    private let registeredDeviceIdKey = "RegisteredDeviceIds"

    func saveRegisteredDeviceId(_ deviceId: String) {
        var savedIds = UserDefaults.standard.stringArray(forKey: registeredDeviceIdKey) ?? []
        if savedIds.contains(deviceId) == false {
            savedIds.append(deviceId)
            UserDefaults.standard.set(savedIds, forKey: registeredDeviceIdKey)
        }
    }

    func loadRegisteredDeviceIds() -> [String] {
        return UserDefaults.standard.stringArray(forKey: registeredDeviceIdKey) ?? []
    }

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

    func saveRegisteredKickboard(deviceId: String, latitude: Double, longitude: Double, battery: Int) {
        var existing = KickboardManager.shared.loadKickboards()
        let newKickboard = KickboardModel(deviceId: deviceId, latitude: latitude, longitude: longitude, battery: battery)
        existing.append(newKickboard)
        KickboardManager.shared.saveKickboards(existing)
    }

}

