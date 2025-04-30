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

    private let mapService = MapService()
    private var isRegisterModeOn: Bool = false

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
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        return view
    }()

    private lazy var moveToCurrentLocationButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "moveToCurrentLocationButton")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(didTapCurrentLocationButton), for: .touchUpInside)
        return button
    }()

    private let registerModeToggleButtonBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        return view
    }()


    private lazy var registerModeToggleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pin.slash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapRegisterModeToggleButton), for: .touchUpInside)
        return button
    }()

    // 중앙 고정 핀 이미지
    private let centerPinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "pin.fill") // 나중에 커스텀
        imageView.tintColor = .purple
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true // 처음에는 숨겨놓기
        return imageView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCenterPinTap()

        // 앱 시작할 때 경복궁 좌표로 지도 이동
        let seoulLatLng = NMGLatLng(lat: 37.579617, lng: 126.977041)
        let cameraUpdate = NMFCameraUpdate(scrollTo: seoulLatLng)
        cameraUpdate.animation = .none
        mapView.moveCamera(cameraUpdate)

        KickboardManager.shared.initializeDefaultKickboards()
        let kickboards = KickboardManager.shared.loadKickboards()
        print("불러온 킥보드 수:", kickboards.count)
        mapService.addKickboardMarkers(kickboards, mapView: mapView) { [weak self] deviceId in
                self?.presentRentModal(for: deviceId)
            }


    }

    private func presentRentModal(for deviceId: String) {
        print("마커 클릭(대여UX) 기기코드: \(deviceId)")

        let modal = RentModalViewController()
        modal.deviceId = deviceId

        if let sheet = modal.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }

        present(modal, animated: true)
    }

    private func setupUI() {
        [mapView, adressInputField, adressSearchButton, moveToCurrentLocationBackgroundView,
         moveToCurrentLocationButton,registerModeToggleButtonBackgroundView,
         registerModeToggleButton, centerPinImageView].forEach { view.addSubview($0) }

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

        centerPinImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(40) // 크기는 자유롭게 조절 가능
        }
    }

    // 중앙 핀 터치했을 때 등록 모달 띄우기
    private func setupCenterPinTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCenterPin))
        centerPinImageView.isUserInteractionEnabled = true
        centerPinImageView.addGestureRecognizer(tapGesture)
    }


    // 검색 버튼 클릭 시 동작
    @objc private func didTapSearchButton() {
        // 텍스트 필드 입력값 가져오기
        guard let address = adressInputField.text, !address.isEmpty else {
            showAlert(title: "입력 오류", message: "주소를 입력해주세요.")
            return
        }

        // AddressSearchAPIManager 통해 API 요청
        AddressSearchAPIManager.shared.fetchCoordinate(address: address) { [weak self] coordinate in
            DispatchQueue.main.async {
                guard let self = self else { return }

                if let coordinate = coordinate {
                    // 성공하면 지도 이동
                    let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: coordinate.latitude, lng: coordinate.longitude))
                    self.mapView.moveCamera(cameraUpdate)
                } else {
                    // 실패하면 Alert
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

            let image = UIImage(systemName: "pin", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
            registerModeToggleButton.setImage(image, for: .normal)

            centerPinImageView.isHidden = false

        } else {
            print("등록 모드 비활성화")

            let image = UIImage(systemName: "pin.slash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
            registerModeToggleButton.setImage(image, for: .normal)

            centerPinImageView.isHidden = true
        }
    }

    @objc private func didTapCenterPin() {
        print("중앙 핀 눌림 - 등록 모달 띄우기")

        let centerCoordinate = mapView.cameraPosition.target
        print("현재 지도 중앙 좌표:", centerCoordinate.lat, centerCoordinate.lng)

        let registerModalVC = RegisterModalViewController()
        if let sheet = registerModalVC.sheetPresentationController {
            sheet.detents = [.custom(resolver: { _ in return 300 })]
            sheet.prefersGrabberVisible = true
        }

        present(registerModalVC, animated: true)
    }




}
