//
//  HomeViewController.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import UIKit
import SnapKit
import NMapsMap

class HomeViewController: UIViewController {

    // 네이버 지도
    private let mapView: NMFMapView = {
        let map = NMFMapView()
        return map
    }()

    private let adressInputField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3) // 한번에 배경+알파
        textField.layer.cornerRadius = 30
        textField.clipsToBounds = true
        textField.borderStyle = .roundedRect
        return textField
    }()


    private lazy var adressSearchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25)), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        return button
    }()

    private let moveToCurrentLocationBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3) // 원하는 배경색
        view.layer.cornerRadius = 25 // 동그라미 (width, height의 절반)
        view.clipsToBounds = true
        return view
    }()

    private lazy var moveToCurrentLocationButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "moveToCurrentLocationButton") // 그냥 원본 이미지
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(didTapCurrentLocationButton), for: .touchUpInside)
        return button
    }()

    private let registerModeToggleButtonBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3) // 원하는 배경색
        view.layer.cornerRadius = 25 // 동그라미 (width, height의 절반)
        view.clipsToBounds = true
        return view
    }()


    private lazy var registerModeToggleButton: UIButton = {
        let button = UIButton()
        // 심볼을 포인트 크기 40으로 설정해서 버튼 이미지로 적용
        button.setImage(UIImage(systemName: "pin.slash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapRegisterModeToggleButton), for: .touchUpInside)
        return button
    }()

    // Todo: 나중에 버튼이 매끄럽게 등장, 사라지는 애니메이션 구현
    private lazy var addKickboardButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.layer.cornerRadius = 25
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.addTarget(self, action: #selector(didTapAddKickboardButton), for: .touchUpInside)

        // 숨김 여부 설정
        button.isHidden = true

        return button
    }()

    private var isRegisterModeOn: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }

    private func setupUI() {
        [mapView, adressInputField, adressSearchButton, moveToCurrentLocationBackgroundView, moveToCurrentLocationButton,registerModeToggleButtonBackgroundView,
         registerModeToggleButton, addKickboardButton].forEach { view.addSubview($0) }

        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        adressInputField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(40)
            make.trailing.equalToSuperview().inset(40)
            make.height.equalTo(60)
        }

        adressSearchButton.snp.makeConstraints { make in
            make.centerX.equalTo(adressInputField).offset(125)
            make.centerY.equalTo(adressInputField)
            make.width.height.equalTo(40)
        }

        moveToCurrentLocationButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-47)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-43)
            make.width.height.equalTo(30)
        }

        moveToCurrentLocationBackgroundView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-37.5)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-34)
            make.width.height.equalTo(50)
        }

        registerModeToggleButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-36.5)
            make.bottom.equalTo(moveToCurrentLocationButton.snp.top).offset(-20)
            make.width.height.equalTo(50)
        }

        registerModeToggleButtonBackgroundView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-37.5)
            make.bottom.equalTo(moveToCurrentLocationButton.snp.top).offset(-21)
            make.width.height.equalTo(50)
        }

        addKickboardButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(50)
        }
    }

    // 검색 버튼 클릭 시 동작
    @objc private func didTapSearchButton() {
        // 1. 텍스트 필드 입력값 가져오기
        guard let address = adressInputField.text, !address.isEmpty else {
            showAlert(title: "입력 오류", message: "주소를 입력해주세요.")
            return
        }

        // 2. AddressSearchAPIManager 통해 API 요청
        AddressSearchAPIManager.shared.fetchCoordinate(address: address) { [weak self] coordinate in
            DispatchQueue.main.async {
                guard let self = self else { return }

                if let coordinate = coordinate {
                    // 3. 성공하면 지도 이동
                    let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: coordinate.latitude, lng: coordinate.longitude))
                    self.mapView.moveCamera(cameraUpdate)
                } else {
                    // 4. 실패하면 Alert
                    self.showAlert(title: "검색 실패", message: "주소를 찾을 수 없습니다.")
                }
            }
        }
    }


    // 현위치 이동 버튼 클릭 시 동작
    @objc private func didTapCurrentLocationButton() {
        let latitude: Double = 37.50238307905
        let longitude: Double = 127.0445569933

        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude, lng: longitude))
        cameraUpdate.animation = .easeIn
        mapView.moveCamera(cameraUpdate)

        // 마커 추가
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: latitude, lng: longitude)
        marker.iconImage = NMFOverlayImage(name: "spartaRogo") // 내 커스텀 이미지
        marker.width = 60  // 크기 조정 가능
        marker.height = 40
        marker.mapView = mapView
    }


    @objc private func didTapRegisterModeToggleButton() {
        isRegisterModeOn.toggle()

        if isRegisterModeOn {
            print("등록 모드 활성화")
            addKickboardButton.isHidden = false

            // 아이콘을 "pin"으로 변경
            let image = UIImage(systemName: "pin", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
            registerModeToggleButton.setImage(image, for: .normal)
        } else {
            print("등록 모드 비활성화")
            addKickboardButton.isHidden = true

            // 아이콘을 "pin.slash"로 변경
            let image = UIImage(systemName: "pin.slash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
            registerModeToggleButton.setImage(image, for: .normal)
        }
    }


    // Add 버튼 클릭 시 동작
    @objc private func didTapAddKickboardButton() {
        print("Add 버튼 클릭 - RegisterModal 띄우기 예정")
    }

}
