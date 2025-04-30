////
////  LoginViewController.swift
////  onboarding
////
////  Created by ByonJoonYoung on 4/28/25.
////
//
import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    //모달 레이아웃 테스트용
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        let modalVC = RegisterModalViewController()
        modalVC.modalPresentationStyle = .pageSheet
        self.present(modalVC, animated: true)
    }
}
