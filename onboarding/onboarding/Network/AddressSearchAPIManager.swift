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
        let clientId = "3xbrvwl2jp"
        let clientSecret = "hK23J2NlC95HNUaMScTT0AwFhsjLkqNzX8NR6yP5"

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

    func fetchAddress(latitude: Double, longitude: Double, completion: @escaping (String?) -> Void) {
        let baseUrl = "https://maps.apigw.ntruss.com/map-reversegeocode/v2/gc"

        let clientId = "3xbrvwl2jp"
        let clientSecret = "hK23J2NlC95HNUaMScTT0AwFhsjLkqNzX8NR6yP5"

        guard let url = URL(string: "\(baseUrl)?coords=\(longitude),\(latitude)&orders=roadaddr,addr&output=json") else {
            print("URL 생성 실패")
            completion(nil)
            return
        }
        print("주소 요청 URL: \(url.absoluteString)")

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(clientId, forHTTPHeaderField: "X-NCP-APIGW-API-KEY-ID")
        request.addValue(clientSecret, forHTTPHeaderField: "X-NCP-APIGW-API-KEY")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("주소 변환 네트워크 에러:", error ?? "알 수 없음")
                completion(nil)
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                print("주소 응답 결과 JSON:", json ?? [:])
                if let results = (json?["results"] as? [[String: Any]])?.first,
                   let region = results["region"] as? [String: Any],
                   let area1 = region["area1"] as? [String: Any],
                   let area2 = region["area2"] as? [String: Any],
                   let area3 = region["area3"] as? [String: Any] {

                    let fullAddress = "\(area1["name"] ?? "") \(area2["name"] ?? "") \(area3["name"] ?? "")"
                    completion(fullAddress)
                } else {
                    completion(nil)
                }
            } catch {
                print("주소 디코딩 실패:", error)
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
