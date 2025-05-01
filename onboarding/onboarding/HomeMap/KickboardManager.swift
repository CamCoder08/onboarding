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
        let existing = userDefaults.integer(forKey: countKey)
        if existing > 0 { return } // 이미 저장돼 있으면 패스

        let defaultList: [KickboardModel] = [
            KickboardModel(deviceId: "333098A", latitude: 37.583331, longitude: 126.973546, battery: 90),
            KickboardModel(deviceId: "333012A", latitude: 37.581770, longitude: 126.973626, battery: 85),
            KickboardModel(deviceId: "333287A", latitude: 37.576271, longitude: 126.972529, battery: 80),
            KickboardModel(deviceId: "333044F", latitude: 37.576512, longitude: 126.979560, battery: 95),
            KickboardModel(deviceId: "333567C", latitude: 37.577675, longitude: 126.980577, battery: 88),
            KickboardModel(deviceId: "333484C", latitude: 37.579796, longitude: 126.973047, battery: 60),
            KickboardModel(deviceId: "333882B", latitude: 37.581145, longitude: 126.980309, battery: 75),
            KickboardModel(deviceId: "333765ED", latitude: 37.582796, longitude: 126.980079, battery: 65),
            KickboardModel(deviceId: "333211E", latitude: 37.583735, longitude: 126.977858, battery: 92),
            KickboardModel(deviceId: "333741F", latitude: 37.581619, longitude: 126.971714, battery: 70),
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

    func addKickboard(_ new: KickboardModel) {
        var current = loadKickboards()
        current.append(new)
        saveKickboards(current)
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

