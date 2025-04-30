//
//  AddressSearchAPIManager.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import Foundation
import CoreLocation

class AddressSearchAPIManager {

    static let shared = AddressSearchAPIManager()
    private init() {}

    // 주소(한글)를 받아서 위도/경도로 변환하는 함수
    func fetchCoordinate(address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {

        // 기본 URL
        let baseUrl = "https://maps.apigw.ntruss.com/map-geocode/v2/geocode"

        // 네이버 콘솔에서 발급받은 Client ID / Secret
        let clientId = "hio0xaude8"
        let clientSecret = "lCt2RzzrYmvbh6BGS5jOGj97z83mMuD6v8i7CCjb"

        // 한글 주소를 URL에 넣기 위해 인코딩
        guard let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseUrl)?query=\(encodedAddress)") else {
            completion(nil)
            return
        }

        // 요청(Request)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(clientId, forHTTPHeaderField: "X-NCP-APIGW-API-KEY-ID")
        request.addValue(clientSecret, forHTTPHeaderField: "X-NCP-APIGW-API-KEY")

        // URLSession으로 네트워크 통신
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            guard let data = data, error == nil else {
                print("네트워크 에러:", error ?? "알 수 없음")
                completion(nil)
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(AddressSearchResponse.self, from: data)

                if let first = result.addresses.first,
                   let lat = Double(first.y),
                   let lng = Double(first.x) {
                    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                    completion(coordinate)
                } else {
                    completion(nil)
                }
            } catch {
                print("디코딩 실패:", error)
                completion(nil)
            }
        }
        task.resume()
    }
}

// 네이버 Geocoding API 응답 모델
struct AddressSearchResponse: Codable {
    let addresses: [Address]
}

struct Address: Codable {
    let x: String // 경도
    let y: String // 위도
}
