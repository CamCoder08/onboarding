//
//  RentModalViewController.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import UIKit
import SnapKit

class RentModalViewController: UIViewController {
    var deviceId: String?
    
    let rentTitle = UILabel()
    let boardNum = UILabel()
    let boardImg = UIImageView()
    let batteryImg = UIImageView()
    let batteryPercent = UILabel()
    
    let chargeArea = UIView()
    let unlock = UILabel()
    let unlockCharge = UILabel()
    let perSecond = UILabel()
    let perSecondCharge = UILabel()
    
    let rentalButton = UIButton()
    
    let runningTimeLabel = UILabel()
    let userRunningTime = UILabel()

    let paymentLabel = UILabel()
    let userPayment = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        rentalUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let sheet = self.sheetPresentationController {
            sheet.detents = [.custom { _ in 318 }]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
        }
        
    }
    
    private func rentalUI() {
        
        view.addSubview(rentTitle)
        view.addSubview(boardNum)
        view.addSubview(boardImg)
        view.addSubview(batteryImg)
        view.addSubview(batteryPercent)
        view.addSubview(chargeArea)
        chargeArea.addSubview(unlock)
        chargeArea.addSubview(unlockCharge)
        chargeArea.addSubview(perSecond)
        chargeArea.addSubview(perSecondCharge)
        view.addSubview(rentalButton)
        chargeArea.addSubview(runningTimeLabel)
        chargeArea.addSubview(userRunningTime)
        chargeArea.addSubview(paymentLabel)
        chargeArea.addSubview(userPayment)
        
        runningTimeLabel.isHidden = true
        userRunningTime.isHidden = true
        paymentLabel.isHidden = true
        userPayment.isHidden = true

        rentTitle.text = "onBoard"
        rentTitle.font = UIFont(name: "NotoSansKR-Medium", size: 23)
        rentTitle.textColor = UIColor(red: 0.04, green: 0.04, blue: 0.04, alpha: 1.0)
        rentTitle.snp.makeConstraints() {
            $0.top.equalToSuperview().offset(40)
            $0.leading.equalTo(boardImg.snp.trailing).offset(21)
            $0.trailing.equalToSuperview().offset(152)
        }
        
        boardNum.text = "No. 333018"
        boardNum.font = UIFont(name: "NotoSansKR-Thin", size: 11)
        boardNum.textColor = UIColor(red: 0.04, green: 0.04, blue: 0.04, alpha: 1.0)
        boardNum.snp.makeConstraints {
            $0.top.equalTo(rentTitle.snp.bottom).offset(1)
            $0.leading.equalTo(boardImg.snp.trailing).offset(21)
            $0.trailing.equalToSuperview().offset(193)
        }
        
        boardImg.image = UIImage(named: "대여시작")
        boardImg.snp.makeConstraints {
            $0.height.equalTo(75)
            $0.width.equalTo(78)
            $0.leading.equalToSuperview().offset(40)
            $0.top.equalToSuperview().offset(40)
        }
        
        batteryImg.image = UIImage(systemName: "battery.100percent")
        batteryImg.tintColor = UIColor(red: 0.04, green: 0.04, blue: 0.04, alpha: 1.0)
        batteryImg.contentMode = .scaleAspectFit
        batteryImg.snp.makeConstraints {
            //            $0.top.equalTo(boardNum.snp.bottom).offset(13)
            $0.bottom.equalTo(boardImg.snp.bottom).offset(3)
            $0.leading.equalTo(boardImg.snp.trailing).offset(19)
        }
        
        batteryPercent.text = "100%"
        batteryPercent.font = UIFont(name: "NotoSansKR-Thin", size: 12)
        batteryPercent.textColor = UIColor(red: 0.04, green: 0.04, blue: 0.04, alpha: 1.0)
        batteryPercent.snp.makeConstraints {
            $0.bottom.equalTo(boardImg.snp.bottom)
            $0.leading.equalTo(batteryImg.snp.trailing).offset(5)
        }
        
        chargeArea.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.4)
        chargeArea.layer.cornerRadius = 23
        
        chargeArea.snp.makeConstraints {
            $0.height.equalTo(89)
            $0.width.equalTo(318)
            $0.top.equalTo(batteryImg.snp.bottom).offset(26)
            $0.centerX.equalToSuperview()
        }
        
        unlock.text = "잠금 해제"
        unlock.textColor = UIColor(red: 0.04, green: 0.04, blue: 0.04, alpha: 1.0)
        unlock.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        unlock.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(44)
        }
        
        unlockCharge.text = "0원"
        unlockCharge.textColor = UIColor(red: 0.04, green: 0.04, blue: 0.04, alpha: 1.0)
        unlockCharge.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        unlockCharge.snp.makeConstraints {
            $0.top.equalTo(unlock.snp.bottom).offset(6)
            $0.centerX.equalTo(unlock.snp.centerX)
        }
        
        
        perSecond.text = "초당 요금"
        perSecond.textColor = UIColor(red: 0.04, green: 0.04, blue: 0.04, alpha: 1.0)
        perSecond.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        perSecond.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(44)
        }
        
        
        perSecondCharge.text = "40원"
        perSecondCharge.textColor = UIColor(red: 0.04, green: 0.04, blue: 0.04, alpha: 1.0)
        perSecondCharge.font = UIFont(name: "NotoSansKR-Thin", size: 14)
        perSecondCharge.snp.makeConstraints {
            $0.top.equalTo(perSecond.snp.bottom).offset(6)
            $0.centerX.equalTo(perSecond.snp.centerX)
        }
        
        rentalButton.setTitle("대여하기", for: .normal)
        rentalButton.setTitleColor(.white, for: .normal)
        rentalButton.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 20)
        //cgcolor에는 .whitw, .black 같은 색 프로퍼티 없어서 옆처럼 써야함
        
        rentalButton.backgroundColor =  UIColor(red: 0.36, green: 0.68, blue: 0.93, alpha: 1.0)
        rentalButton.layer.cornerRadius = 20
        rentalButton.layer.masksToBounds = true
        rentalButton.addTarget(self, action: #selector(rentalTapped), for: .touchUpInside)
        rentalButton.snp.makeConstraints {
            $0.top.equalTo(chargeArea.snp.bottom).offset(27)
//            $0.trailing.leading.equalToSuperview().inset(158)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(53)
            $0.width.equalTo(110)
        }
        
        runningTimeLabel.text = "주행 시간"
        runningTimeLabel.textColor = UIColor(red: 0.04, green: 0.04, blue: 0.04, alpha: 1.0)
        runningTimeLabel.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        runningTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(44)
        }
        
        userRunningTime.text = "02:00"
        userRunningTime.textColor = UIColor(red: 0.04, green: 0.04, blue: 0.04, alpha: 1.0)
        userRunningTime.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        userRunningTime.snp.makeConstraints {
            $0.top.equalTo(runningTimeLabel.snp.bottom).offset(6)
            $0.centerX.equalTo(runningTimeLabel.snp.centerX)
        }
        
        paymentLabel.text = "결제 금액"
        paymentLabel.textColor = UIColor(red: 0.04, green: 0.04, blue: 0.04, alpha: 1.0)
        paymentLabel.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        paymentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(44)
        }
        
        userPayment.text = "2300원"
        userPayment.textColor = UIColor(red: 0.04, green: 0.04, blue: 0.04, alpha: 1.0)
        userPayment.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        userPayment.snp.makeConstraints {
            $0.top.equalTo(paymentLabel.snp.bottom).offset(6)
            $0.centerX.equalTo(paymentLabel.snp.centerX)
        }

    }
    
    var isRented = false

    @objc func rentalTapped() {
        isRented.toggle()
        updateUI(forRenting: isRented)
    }

    func updateUI(forRenting: Bool) {
        if forRenting {
            
            
            boardImg.image = UIImage(named: "대여중")
            rentTitle.text = "onBoarding ..."
            batteryPercent.text = "80%"
            
            
            unlock.isHidden = true
            unlockCharge.isHidden = true
            perSecond.isHidden = true
            perSecondCharge.isHidden = true
            
            
            runningTimeLabel.isHidden = false
            userRunningTime.isHidden = false
            paymentLabel.isHidden = false
            userPayment.isHidden = false
            
            rentalButton.setTitle("반납하기", for: .normal)
            
        } else {
            
            boardImg.image = UIImage(named: "대여시작")
            rentTitle.text = "onBoard"
            batteryPercent.text = "100%"
            
            
            unlock.isHidden = false
            unlockCharge.isHidden = false
            perSecond.isHidden = false
            perSecondCharge.isHidden = false
            
            
            runningTimeLabel.isHidden = true
            userRunningTime.isHidden = true
            paymentLabel.isHidden = true
            userPayment.isHidden = true
            
            rentalButton.setTitle("대여하기", for: .normal)
        }
    }


    
    
}
