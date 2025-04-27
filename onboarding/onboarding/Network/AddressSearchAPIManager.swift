//
//  AddressSearchAPIManager.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import Foundation

class AddressSearchAPIManager {
    static let shared = AddressSearchAPIManager()

    private init() {}

    func searchAddress(keyword: String, completion: @escaping (Result<(Double, Double), Error>) -> Void) {
        // 네이버 주소 검색 API를 호출하는 코드 작성 예정
    }
}


/*
 이 파일은 네이버 지도 API를 이용해서 주소를 검색하고, 검색 결과를 위도/경도 좌표로 변환하는 역할을 합니다.
 HomeViewController에서 주소 검색 기능을 구현할 때 이 파일을 사용하게 됩니다.
 URLSession을 이용해서 직접 네트워크 통신을 하고 있습니다.
 통신 실패 시 에러 처리를 꼭 함께 고려해서 작성할 예정입니다.
 */
