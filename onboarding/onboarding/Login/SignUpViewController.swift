//
//  SignUpViewController.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import UIKit

import UIKit

class SignUpViewController: UIViewController {
    
    // UI Elements
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome onBoard !"
        label.font = UIFont(name: "Nunito-Light",size: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let idLabel = FormLabel(text: "ID")
    private let idTextField = CustomTextField(placeholder: "Enter ID ...")
    
    private let nicknameLabel = FormLabel(text: "Nickname")
    private let nicknameTextField = CustomTextField(placeholder: "Enter nickname ...")
    
    private let passwordLabel = FormLabel(text: "Password")
    private let passwordTextField = CustomTextField(placeholder: "Enter password ...", isSecure: true)
    
    private let confirmPasswordLabel = FormLabel(text: "Confirm Password")
    private let confirmPasswordTextField = CustomTextField(placeholder: "Enter password ...", isSecure: true)
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Go onBoard !", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.937, green: 0.525, blue: 0.729, alpha: 1.0) // #EF86BA
        signUpUI()
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)

    }
    
    
    private func signUpUI() {
        
        view.addSubview(logoImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(idLabel)
        view.addSubview(idTextField)
        view.addSubview(nicknameLabel)
        view.addSubview(nicknameTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordLabel)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(signUpButton)
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(70)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(43)
            $0.width.equalTo(168)
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
        }
        
        idLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(29)
            $0.leading.equalToSuperview().offset(70)
        }
        idTextField.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(70)
            $0.height.equalTo(40)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(20)
            $0.leading.equalTo(idLabel)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(idTextField)
            $0.height.equalTo(40)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(20)
            $0.leading.equalTo(idLabel)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(idTextField)
            $0.height.equalTo(40)
        }
        
        confirmPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.leading.equalTo(idLabel)
        }
        
        confirmPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(confirmPasswordLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(idTextField)
            $0.height.equalTo(40)
        }
        
        signUpButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(confirmPasswordTextField.snp.bottom).offset(40)
        }
    }

    @objc private func signUpButtonTapped() {
        guard let id = idTextField.text, !id.isEmpty,
              let nickname = nicknameTextField.text, !nickname.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            showAlert(title: "Error", message: "모든 필드를 입력해주세요.")
            return
        }
        
        // ID 중복 체크
        if UserManager.shared.isIDDuplicated(id) {
            showAlert(title: "Error", message: "이미 사용 중인 ID입니다.")
            return
        }
        
        // Nickname 중복 체크
        if UserManager.shared.isNicknameDuplicated(nickname) {
            showAlert(title: "Error", message: "이미 사용 중인 닉네임입니다.")
            return
        }
        
        // 비밀번호 일치 확인
        guard password == confirmPassword else {
            showAlert(title: "Error", message: "비밀번호가 일치하지 않습니다.")
            return
        }
        
        // 유저 매니저에 새 유저 등록
        UserManager.shared.registerUser(id: id, password: password, nickname: nickname)
        
        // 회원가입 성공 알림
        showAlert(title: "Success", message: "회원가입이 완료되었습니다.") { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
//        showAlert(title: "Success", message: "회원가입이 완료되었습니다.")

    }

}
