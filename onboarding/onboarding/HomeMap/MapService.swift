//
//  MapService.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import Foundation
import NMapsMap

class MapService {
    private var markerMap: [NMFMarker: String] = [:] // 마커 → 기기코드 매핑 저장

    // 마커 추가 함수
    func addKickboardMarkers(_ list: [KickboardModel], mapView: NMFMapView, onMarkerTap: @escaping (String) -> Void) {
        list.forEach { model in
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: model.latitude, lng: model.longitude)
            marker.mapView = mapView

            print("마커 추가됨:", model.deviceId, model.latitude, model.longitude) // 디버깅용


            // 기기코드 기억해두기
            markerMap[marker] = model.deviceId

            // 마커 탭했을 때 실행할 핸들러 연결
            marker.touchHandler = { [weak self] overlay in
                if let marker = overlay as? NMFMarker,
                   let deviceId = self?.markerMap[marker] {
                    onMarkerTap(deviceId) // 외부로 기기코드 전달
                }
                return true
            }
        }
    }

    // 특정 기기코드에 해당하는 마커를 지도에서 제거하는 함수
    func removeMarker(for deviceId: String) {
        if let marker = markerMap.first(where: { $0.value == deviceId })?.key {
            marker.mapView = nil // 지도에서 제거
            markerMap.removeValue(forKey: marker) // 내부 저장소에서도 제거
        }
    }

}

