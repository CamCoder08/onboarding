//
//  SignUpViewController.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import UIKit
import SnapKit
//
//  SignUpViewController.swift
//  map
//
//  Created by Suzie Kim on 4/26/25.
//
/*
import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: - UI Elements
    private let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "onBoarding"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome on onBoard !"
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let idTextField = CustomTextField(placeholder: "Enter id ...")
    private let passwordTextField = CustomTextField(placeholder: "Enter password ...", isSecure: true)
    private let confirmPasswordTextField = CustomTextField(placeholder: "Enter password ...", isSecure: true)
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Go onBoard !", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setupLayout()
    }
    
    // MARK: - Layout
    private func setupLayout() {
        view.addSubview(logoLabel)
        view.addSubview(welcomeLabel)
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            welcomeLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 20),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            idTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 30),
            idTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            idTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            idTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: idTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: idTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: idTextField.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: idTextField.trailingAnchor),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            signUpButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 50),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc private func signUpButtonTapped() {
        guard let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text,
              password == confirmPassword else {
            showAlert(title: "Error", message: "Passwords do not match")
            return
        }
        
        // 회원가입 완료 처리 (나중에 서버 연결 가능)
        navigationController?.popViewController(animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


}*/
import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: - UI Elements
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "로고"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome onBoard !"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.937, green: 0.525, blue: 0.729, alpha: 1.0) // #EF86BA
        setupLayout()
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)

    }
    
    // MARK: - Layout
    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [
            logoImageView,
            welcomeLabel,
            idLabel, idTextField,
            nicknameLabel, nicknameTextField,
            passwordLabel, passwordTextField,
            confirmPasswordLabel, confirmPasswordTextField,
            signUpButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 400 // 기본 간격은 10
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        // 특수 간격 설정 (Custom Spacing)
        stackView.setCustomSpacing(30, after: logoImageView)         // 로고 → Welcome 문구 간격
        stackView.setCustomSpacing(30, after: welcomeLabel)          // Welcome → ID 입력 시작 간격
        stackView.setCustomSpacing(8, after: idLabel)                // Label → TextField (좁게)
        stackView.setCustomSpacing(30, after: idTextField)           // TextField → 다음 Label
        stackView.setCustomSpacing(8, after: nicknameLabel)
        stackView.setCustomSpacing(30, after: nicknameTextField)
        stackView.setCustomSpacing(8, after: passwordLabel)
        stackView.setCustomSpacing(30, after: passwordTextField)
        stackView.setCustomSpacing(8, after: confirmPasswordLabel)
        stackView.setCustomSpacing(40, after: confirmPasswordTextField) // 마지막 필드 → 버튼
    }
    // 커스텀 텍스트필드
    class CustomTextField: UITextField {
        init(placeholder: String, isSecure: Bool = false) {
            super.init(frame: .zero)
            self.placeholder = placeholder
            self.isSecureTextEntry = isSecure
            self.borderStyle = .none
            self.translatesAutoresizingMaskIntoConstraints = false
            
            let underline = UIView()
            underline.backgroundColor = .black
            underline.translatesAutoresizingMaskIntoConstraints = false
            addSubview(underline)
            
            NSLayoutConstraint.activate([
                underline.heightAnchor.constraint(equalToConstant: 1),
                underline.leadingAnchor.constraint(equalTo: leadingAnchor),
                underline.trailingAnchor.constraint(equalTo: trailingAnchor),
                underline.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    // 커스텀 라벨
    class FormLabel: UILabel {
        init(text: String) {
            super.init(frame: .zero)
            self.text = text
            self.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            self.textColor = .black
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
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
        showAlert(title: "Success", message: "회원가입이 완료되었습니다.")

    }

}
