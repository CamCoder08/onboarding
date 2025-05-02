//
//  HomeViewController.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import UIKit
import SnapKit
import NMapsMap

class HomeViewController: UIViewController, RegisterModalViewControllerDelegate {

    private let mapService = MapService()
    private var isRegisterModeOn: Bool = false

    // 네이버 지도
    private let mapView: NMFMapView = {
        let map = NMFMapView()
        return map
    }()

    private let adressInputField: UITextField = {
        let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 0))
        textField.leftViewMode = .always
//        textField.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        textField.textColor = .white
        textField.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
        textField.layer.cornerRadius = 30
        textField.clipsToBounds = true
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let adressInputFieldShadow: UIView = {
        let shadow = UIView()
        shadow.layer.shadowColor = UIColor.black.cgColor
        shadow.layer.shadowOpacity = 3
        shadow.layer.shadowOffset = CGSize(width: 0, height: 9)
        shadow.layer.shadowRadius = 6
        shadow.backgroundColor = UIColor(red: 194/255, green: 194/255, blue: 194/255, alpha: 0.4)
        shadow.layer.cornerRadius = 30
        shadow.layer.masksToBounds = false
        return shadow
    }()

//    let adressInputShadow: UIView = {
//        let shadow = UIView()
//        shadow.backgroundColor = .clear
//        shadow.layer.shadowColor = UIColor.black.cgColor
//        shadow.layer.shadowOffset = CGSize(width: 0, height: 5)
//        shadow.layer.shadowRadius = 2
//        shadow.layer.shadowOpacity = 100
//        shadow.layer.masksToBounds = false
//
//        return shadow
//    }()


    private lazy var adressSearchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25)), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        return button
    }()

    private let moveToCurrentLocationBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1)
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

    private let moveToCurrentLocationButtonShadow: UIView = {
        let shadow = UIView()
        shadow.layer.shadowColor = UIColor.black.cgColor
        shadow.layer.shadowOpacity = 3
        shadow.layer.shadowOffset = CGSize(width: 0, height: 5)
        shadow.layer.shadowRadius = 6
        shadow.backgroundColor = UIColor(red: 194/255, green: 194/255, blue: 194/255, alpha: 0.4)
        shadow.layer.cornerRadius = 30
        shadow.layer.masksToBounds = false
        return shadow
    }()

    private lazy var registerModeToggleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pin.slash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapRegisterModeToggleButton), for: .touchUpInside)
        return button
    }()

    private let registerModeToggleButtonBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1)
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        return view
    }()


    private let registerModeToggleButtonShadow: UIView = {
        let shadow = UIView()
        shadow.layer.shadowColor = UIColor.black.cgColor
        shadow.layer.shadowOpacity = 3
        shadow.layer.shadowOffset = CGSize(width: 0, height: 5)
        shadow.layer.shadowRadius = 6
        shadow.backgroundColor = UIColor(red: 194/255, green: 194/255, blue: 194/255, alpha: 0.4)
        shadow.layer.cornerRadius = 30
        shadow.layer.masksToBounds = false
        return shadow
    }()
    

    // 중앙 고정 핀 이미지
    private let centerPinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ADD")
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
        modal.delegate = self

        if let sheet = modal.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }

        present(modal, animated: true)
    }

    private func setupUI() {


//        adressInputFieldShadow

        [mapView, adressInputFieldShadow, adressInputField, adressSearchButton, moveToCurrentLocationButtonShadow,
         moveToCurrentLocationBackgroundView, moveToCurrentLocationButton,
         registerModeToggleButtonShadow, registerModeToggleButtonBackgroundView,
         registerModeToggleButton, centerPinImageView].forEach { view.addSubview($0) }

        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

//        textFieldWrapper.snp.makeConstraints { make in
//            make.center.equalTo(adressInputField)
//        }

        // 그림자 뷰에 위치 설정
//        adressInputShadow.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(90)
//            make.leading.trailing.equalToSuperview().inset(40)
//            make.height.equalTo(60)
//        }


//        adressInputField.snp.makeConstraints { make in
//            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0))
//        }

//        adressInputField.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalToSuperview().inset(100)
//            make.width.equalTo()
//        }

        adressInputFieldShadow.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(40)
            make.trailing.equalToSuperview().inset(40)
            make.height.equalTo(60)
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

        moveToCurrentLocationButtonShadow.snp.makeConstraints { make in
            make.edges.equalTo(moveToCurrentLocationBackgroundView)
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

        registerModeToggleButtonShadow.snp.makeConstraints { make in
            make.edges.equalTo(registerModeToggleButtonBackgroundView)
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

    func didRegisterDevice(deviceId: String) {
        print("HomeViewController에서 등록된 기기코드 받음: \(deviceId)")

        // 등록모드 종료 (등록핀 사라짐 + 버튼 아이콘 원상복구)
        isRegisterModeOn = false
        let image = UIImage(systemName: "pin.slash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        registerModeToggleButton.setImage(image, for: .normal)
        centerPinImageView.isHidden = true

        // 마커 추가
        let kickboards = KickboardManager.shared.loadKickboards()
        guard let target = kickboards.first(where: { $0.deviceId == deviceId }) else {
            print("해당 deviceId에 해당하는 킥보드 정보를 찾을 수 없습니다.")
            return
        }

        DispatchQueue.main.async { [weak self] in
            self?.mapService.addKickboardMarkers([target], mapView: self!.mapView) { id in
                self?.presentRentModal(for: id)
            }
        }
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

        let centerCoordinate = mapView.cameraPosition.target
        print("등록 시 좌표:", centerCoordinate.lat, centerCoordinate.lng)

        let registerModalVC = RegisterModalViewController()

        registerModalVC.coordinate = centerCoordinate // 좌표 전달
        registerModalVC.delegate = self



        if let sheet = registerModalVC.sheetPresentationController {
            sheet.detents = [.custom(resolver: { _ in return 300 })]
            sheet.prefersGrabberVisible = true
        }

        present(registerModalVC, animated: true)
    }




}


extension HomeViewController: RentModalDelegate {
    func didRentKickboard(deviceId: String) {
        mapService.removeMarker(for: deviceId)
    }

    func didReturnKickboard(deviceId: String) {
        if let target = KickboardManager.shared.loadKickboards().first(where: { $0.deviceId == deviceId }) {
            mapService.addKickboardMarkers([target], mapView: mapView) { [weak self] id in
                self?.presentRentModal(for: id)
            }
        }
    }
}
