//
//  LoginViewController.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let modalVC = RentModalViewController()
        modalVC.modalPresentationStyle = .pageSheet
        self.present(modalVC, animated: true)
        
    }
}




