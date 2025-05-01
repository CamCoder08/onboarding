//
//  RegisterModalViewController.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import UIKit
import SnapKit
import NMapsMap

protocol RegisterModalViewControllerDelegate: AnyObject {
    func didRegisterDevice(deviceId: String)
}

class RegisterModalViewController: UIViewController {

    var coordinate: NMGLatLng?

    let textLabel = UILabel()
    let deviceNumber = UILabel()
    let picker = UIPickerView()
    let confirm = UIButton()

    var pickerList: [String] = []

    //피커뷰 내용물

    let allDevices = [
        "444001A", "444002B", "444003C", "444004D", "444005E",
        "444006F", "444007G", "444008H", "444009I", "444010J"
    ]



    weak var delegate: RegisterModalViewControllerDelegate?



    override func viewDidLoad() {
        super.viewDidLoad()

        let registered = RegistrationManager.shared.loadRegisteredDeviceIds()
        pickerList = allDevices.filter { !registered.contains($0) }

        view.backgroundColor = .white
        
        view.layer.cornerRadius = 30
        //모달 상단 모서리 두개. minxmin왼쪽 위, maxxmin 오른쪽 위
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        
        setUpUI()
        
        picker.dataSource = self
        picker.delegate = self
        
    }
    



    
    
    private func setUpUI() {
        
        view.addSubview(textLabel)
        view.addSubview(picker)
        view.addSubview(confirm)
        view.addSubview(deviceNumber)
        
        textLabel.text = "onBoard 등록"
        textLabel.font = UIFont(name: "NotoSansKR-Bold", size: 28)
        textLabel.textColor = UIColor(red: 0.04, green: 0.04, blue: 0.04, alpha: 1.0)
        textLabel.textAlignment = .center
        textLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(21)
            $0.centerX.equalToSuperview()
        }
        
        deviceNumber.text = "Device No."
        deviceNumber.textColor = UIColor(red: 0.04, green: 0.04, blue: 0.04, alpha: 1.0)
        deviceNumber.font =  UIFont(name: "NotoSansKR-Light", size: 13)
        deviceNumber.textAlignment = .center
        deviceNumber.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(-10)
            $0.centerX.equalToSuperview()
        }
        
        picker.backgroundColor = .clear
        picker.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.equalTo(textLabel.snp.bottom)
            $0.bottom.equalTo(confirm.snp.top)
//          $0.leading.trailing.equalToSuperview().inset(50)
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
        guard let coordinate = coordinate else { return }

        guard !pickerList.isEmpty else {
                showAlert(title: "오류", message: "더 이상 등록 가능한 킥보드가 없습니다.")
                return
            }

        let selectedRow = picker.selectedRow(inComponent: 0)
        let selectedDevice = pickerList[selectedRow]

        RegistrationManager.shared.saveRegisteredDeviceId(selectedDevice)

        // 새 킥보드 생성
        let new = KickboardModel(
            deviceId: selectedDevice,
            latitude: coordinate.lat,
            longitude: coordinate.lng,
            battery: Int.random(in: 50...100)
        )

        // 먼저 저장
        KickboardManager.shared.addKickboard(new)

        // 저장된 후 전달
        delegate?.didRegisterDevice(deviceId: selectedDevice)

        // 주소와 날짜 저장
        AddressSearchAPIManager.shared.fetchAddress(latitude: coordinate.lat, longitude: coordinate.lng) { address in
            let dateString = DateFormatter.kickboardFormatWithTime.string(from: Date())
            RegistrationManager.shared.saveDeviceInfo(
                deviceId: selectedDevice,
                address: address ?? "주소 불러오기 실패",
                date: dateString
            )
        }

        // 모달 닫기
        dismiss(animated: true)

        // 피커뷰에서 제거
        pickerList.remove(at: selectedRow)
        picker.reloadAllComponents()
    }


    

}


