//
//  RegistrationViewController.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import UIKit
import SnapKit

class RegistrationViewController: UIViewController {
    
    private let RegisterationLabel = UILabel()
    private let underlineView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        RegisterationLabel.text = "Registeration"
        RegisterationLabel.font = UIFont.boldSystemFont(ofSize: 32)
        
        [
            RegisterationLabel,
            underlineView
        ].forEach { view.addSubview($0) }
        
        RegisterationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(30)
        }
        
        underlineView.backgroundColor = .black
        underlineView.snp.makeConstraints {
            $0.top.equalTo(RegisterationLabel.snp.bottom).offset(3)
            $0.leading.equalTo(RegisterationLabel.snp.leading)
            $0.trailing.equalTo(RegisterationLabel.snp.trailing)
            $0.height.equalTo(1)
        }
    }
}
