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

    private let userDefaults = UserDefaults.standard

    private let countKey = "kickboard_count"
    private let deviceIdPrefix = "kickboard_deviceId_"
    private let latitudePrefix = "kickboard_lat_"
    private let longitudePrefix = "kickboard_lng_"
    private let batteryPrefix = "kickboard_battery_"

    // 기본 킥보드 10대 저장
    func initializeDefaultKickboards() {
        userDefaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!) // 유저데이트 초기화 코드 ㄷㄷ
        let existing = userDefaults.integer(forKey: countKey)
        if existing > 0 { return } // 이미 저장돼 있으면 패스

        let defaultList: [KickboardModel] = [
            KickboardModel(deviceId: "333098A", latitude: 37.579617, longitude: 126.974046, battery: 90),
            KickboardModel(deviceId: "333012A", latitude: 37.579617, longitude: 126.974046, battery: 85),
            KickboardModel(deviceId: "333287A", latitude: 37.579617, longitude: 126.976044, battery: 80),
            KickboardModel(deviceId: "333044F", latitude: 37.579617, longitude: 126.975045, battery: 95),
            KickboardModel(deviceId: "333567C", latitude: 37.579617, longitude: 126.974046, battery: 88),
            KickboardModel(deviceId: "333484C", latitude: 37.579617, longitude: 126.973047, battery: 60),
            KickboardModel(deviceId: "333882B", latitude: 37.579617, longitude: 126.972048, battery: 75),
            KickboardModel(deviceId: "333765ED", latitude: 37.579617, longitude: 126.971049, battery: 65),
            KickboardModel(deviceId: "333211E", latitude: 37.579617, longitude: 126.970050, battery: 92),
            KickboardModel(deviceId: "333741F", latitude: 37.579617, longitude: 126.969051, battery: 70),
        ]

        saveKickboards(defaultList)
    }

    func saveKickboards(_ kickboards: [KickboardModel]) {
        userDefaults.set(kickboards.count, forKey: countKey)

        for (index, item) in kickboards.enumerated() {
            userDefaults.set(item.deviceId, forKey: deviceIdPrefix + "\(index)")
            userDefaults.set(item.latitude, forKey: latitudePrefix + "\(index)")
            userDefaults.set(item.longitude, forKey: longitudePrefix + "\(index)")
            userDefaults.set(item.battery, forKey: batteryPrefix + "\(index)")
        }
    }

    func loadKickboards() -> [KickboardModel] {
        let count = userDefaults.integer(forKey: countKey)
        var list: [KickboardModel] = []

        for i in 0..<count {
            guard let id = userDefaults.string(forKey: deviceIdPrefix + "\(i)") else { continue }
            let lat = userDefaults.double(forKey: latitudePrefix + "\(i)")
            let lng = userDefaults.double(forKey: longitudePrefix + "\(i)")
            let bat = userDefaults.integer(forKey: batteryPrefix + "\(i)")
            list.append(KickboardModel(deviceId: id, latitude: lat, longitude: lng, battery: bat))
        }

        return list
    }
}

