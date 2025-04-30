//
//  RentModalViewController.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import UIKit
import SnapKit

class RentModalViewController: UIViewController {

    var deviceId: String? // HomeViewController에서 전달 받는 기기코드

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        print("RentModal 열림 - 기기코드:", deviceId ?? "없음")
    }
}

