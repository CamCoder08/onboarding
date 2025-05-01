//
//  HistoryDisplayManager.swift
//  onboarding
//
//  Created by ios_starter on 4/30/25.
//

import Foundation

struct HistoryDisplayModel {
    let deviceId: String
    let fee: String
    let returnTime: String
}

class HistoryDisplayManager {
    
    static let manager = HistoryDisplayManager()
    private let userDefaults = UserDefaults.standard
    
    private let historyKey = "rental_"
    private let countKey = "rental_count"
    
    private init() {}

    func save(history: HistoryDisplayModel) {
        let currentCount = userDefaults.integer(forKey: countKey)

        userDefaults.set(history.deviceId, forKey: "\(historyKey)\(currentCount)_deviceId")
        userDefaults.set(history.fee, forKey: "\(historyKey)\(currentCount)_fee")
        userDefaults.set(history.returnTime, forKey: "\(historyKey)\(currentCount)_returnTime")

        userDefaults.set(currentCount + 1, forKey: countKey)
    }

    func display() -> [HistoryDisplayModel] {
        let count = userDefaults.integer(forKey: countKey)
        var result: [HistoryDisplayModel] = []

        for i in 0..<count {
            let deviceId = userDefaults.string(forKey: "\(historyKey)\(i)_deviceId") ?? "-"
            let fee = userDefaults.string(forKey: "\(historyKey)\(i)_fee") ?? "-"
            let returnTime = userDefaults.string(forKey: "\(historyKey)\(i)_returnTime") ?? "-"

            let history = HistoryDisplayModel(deviceId: deviceId, fee: fee, returnTime: returnTime)
            result.append(history)
        }

        return result
    }
}
