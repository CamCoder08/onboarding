//
//  RegisterModalViewController.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import UIKit
import SnapKit

protocol RegisterModalViewControllerDelegate: AnyObject {
    func didRegisterDevice(deviceId: String)
}

class RegisterModalViewController: UIViewController {
    
    let textLabel = UILabel()
    let picker = UIPickerView()
    let confirm = UIButton()
    
    //피커뷰 내용물
    let pickerList = [
        "333098A", "333012A", "333287A", "333044F", "333567C",
        "333484C", "333882B", "333765ED", "333211E", "333741F"
    ]
    
    weak var delegate: RegisterModalViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.layer.cornerRadius = 30
        //모달 상단 모서리 두개. minxmin왼쪽 위, maxxmin 오른쪽 위
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        
        setUpUI()
        
        picker.dataSource = self
        picker.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let sheet = self.sheetPresentationController {
            sheet.detents = [.custom { _ in 348 }]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
        }
    }

    
    
    private func setUpUI() {
        
        view.addSubview(textLabel)
        view.addSubview(picker)
        view.addSubview(confirm)
        
        textLabel.text = "onBoard 등록"
        textLabel.font = .systemFont(ofSize: 28)
        textLabel.textColor = UIColor(red: 0.04, green: 0.04, blue: 0.04, alpha: 1.0)
        textLabel.textAlignment = .center
        textLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(21)
            $0.centerX.equalToSuperview()
        }
        
        picker.backgroundColor = .clear
        picker.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.equalTo(textLabel.snp.bottom)
            $0.bottom.equalTo(confirm.snp.top)
//            $0.leading.trailing.equalToSuperview().inset(50)
            $0.width.equalToSuperview().inset(60)
        }
        
        
        confirm.setTitle("Yes", for: .normal)
        confirm.setTitleColor(UIColor(red: 0.04, green: 0.04, blue: 0.04, alpha: 1.0), for: .normal)
        confirm.titleLabel?.font = .systemFont(ofSize: 22)
        //cgcolor에는 .whitw, .black 같은 색 프로퍼티 없어서 옆처럼 써야함
        confirm.layer.borderColor = UIColor(red: 0.04, green: 0.04, blue: 0.04, alpha: 1.0).cgColor
        confirm.layer.borderWidth = 1
        confirm.layer.cornerRadius = 20
        confirm.layer.masksToBounds = true
        confirm.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        confirm.snp.makeConstraints {
            $0.top.equalTo(picker.snp.bottom).offset(50)
            $0.trailing.leading.equalToSuperview().inset(168)
            $0.height.equalTo(41)
            $0.width.equalTo(56)
        }
        
        
    }
    
    //    피커뷰에서 선택한 기기코드를 가져온다
    //    -> picker.selectedRow(inComponent: 0) 사용
    //    선택한 기기코드를 저장하거나 넘긴다
    //    RegistrationManager 또는 Delegate 이용
    //    피커뷰에서 선택한 기기 정보를 필요에 따라 RegistrationManager를 통해 저장 및 Delegate를 통해 다른 화면(HomeViewController)로 전달
    //    모달을 닫는다 -> dismiss(animated: true) 사용
    
    @objc func confirmTapped() {
        let selectedRow = picker.selectedRow(inComponent: 0)
        let selectedDevice = pickerList[selectedRow]
        
        print("선택 기기: \(selectedDevice)")
        
        RegistrationManager.shared.saveDeviceInfo(
            deviceId:selectedDevice,
            address: "수원시 팔달구 행궁동",
            date: "2025.04.27"
        )
        
        delegate?.didRegisterDevice(deviceId: selectedDevice)
        
        dismiss(animated: true, completion: nil)
    }
}


