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
        textField.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3) // 한 번에 배경+알파
        textField.layer.cornerRadius = 30
        textField.clipsToBounds = true
        textField.borderStyle = .roundedRect
        return textField
    }()


    private lazy var adressSearchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)

        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 1, height: 3)
        button.layer.shadowRadius = 5
        return button
    }()

    // Todo: PNG 이미지파일 여백이 없어서 둥근 배경 적용불가.
    private lazy var moveToCurrentLocationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "moveToCurrentLocationButton")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor.darkGray.withAlphaComponent(0.5)
        button.addTarget(self, action: #selector(didTapCurrentLocationButton), for: .touchUpInside)

        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 1, height: 3)
        button.layer.shadowRadius = 5
        return button
    }()

    private lazy var registerModeToggleButton: UIButton = {
        let button = UIButton()
        // 심볼을 포인트 크기 40으로 설정해서 버튼 이미지로 적용
        button.setImage(UIImage(systemName: "pin.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
        button.tintColor = .darkGray // 처음에는 다크그레이
        button.alpha = 0.5 // 처음에는 반투명
        button.addTarget(self, action: #selector(didTapRegisterModeToggleButton), for: .touchUpInside)

        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 1, height: 3)
        button.layer.shadowRadius = 5
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

//        button.layer.shadowColor = UIColor.black.cgColor
//        button.layer.shadowOpacity = 0.5
//        button.layer.shadowOffset = CGSize(width: 1, height: 3)
//        button.layer.shadowRadius = 10

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
        [mapView, adressInputField, adressSearchButton, moveToCurrentLocationButton,
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
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-120)
            make.width.height.equalTo(50)
        }

        registerModeToggleButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalTo(moveToCurrentLocationButton.snp.top).offset(-16)
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
        print("검색 버튼 클릭 - 주소 검색 기능 연결 예정")
    }

    // 현위치 이동 버튼 클릭 시 동작
    @objc private func didTapCurrentLocationButton() {
        print("현위치 이동 버튼 클릭 - 고정 좌표 이동 기능 연결 예정")
    }

    // 등록 버튼 클릭 시 동작
    @objc private func didTapRegisterModeToggleButton() {
        isRegisterModeOn.toggle()

        if isRegisterModeOn {
            print("등록 모드 활성화")
            registerModeToggleButton.tintColor = .systemGreen
            registerModeToggleButton.alpha = 0.5
            addKickboardButton.isHidden = false
        } else {
            print("등록 모드 비활성화")
            registerModeToggleButton.tintColor = .darkGray
            registerModeToggleButton.alpha = 0.5
            addKickboardButton.isHidden = true
        }
    }

    // Add 버튼 클릭 시 동작
    @objc private func didTapAddKickboardButton() {
        print("Add 버튼 클릭 - RegisterModal 띄우기 예정")
    }

}
