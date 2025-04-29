//
//  LoginViewController.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//
import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    
    // MARK: - UI 요소
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome onBoard !"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private let idLabel = FormLabel(text: "ID")
    private let idTextField = CustomTextField(placeholder: "Enter id ...")
    
    private let passwordLabel = FormLabel(text: "Password")
    private let passwordTextField = CustomTextField(placeholder: "Enter password ...", isSecure: true)
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let snsStackView: UIStackView = {
        let icons = ["kakao", "naver", "mail"] // <- Assets에 추가한 이미지 이름
        let views = icons.map { UIImage(named: $0) }.compactMap { image -> UIImageView? in
            let iv = UIImageView(image: image)
            iv.contentMode = .scaleAspectFit
            iv.snp.makeConstraints { $0.width.height.equalTo(40) }
            return iv
        }
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = .horizontal
        stack.spacing = 30
        stack.alignment = .center
        return stack
    }()
    
    // MARK: - 생명주기
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.937, green: 0.525, blue: 0.729, alpha: 1.0) // #EF86BA
        
        // 회원가입 버튼 연결
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
            
        // 로그인 버튼 연결
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        setupLayout()
    }
    
    // MARK: - 레이아웃 설정
    private func setupLayout() {
        [logoImageView, welcomeLabel,
         idLabel, idTextField,
         passwordLabel, passwordTextField,
         loginButton, signUpButton, snsStackView].forEach { view.addSubview($0) }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        idLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(30)
        }
        idTextField.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(40)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(20)
            $0.leading.equalTo(idLabel)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(idTextField)
            $0.height.equalTo(40)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
        
        // view.addSubview(signUpButton)
        [logoImageView, welcomeLabel,
         idLabel, idTextField,
         passwordLabel, passwordTextField,
         loginButton, signUpButton, snsStackView].forEach { view.addSubview($0) }

        signUpButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc private func signUpButtonTapped() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc private func loginButtonTapped() {
        let enteredID = idTextField.text ?? ""
        let enteredPassword = passwordTextField.text ?? ""
        
        // 1. ID 존재 여부 확인
        guard let user = UserManager.shared.userList.first(where: { $0.id == enteredID }) else {
            showAlert(title: "Login Failed", message: "존재하지 않는 ID입니다.")
            return
        }
        
        // 2. Password 일치 여부 확인
        guard user.password == enteredPassword else {
            showAlert(title: "Login Failed", message: "비밀번호가 일치하지 않습니다.")
            return
        }
        
        // 3. 로그인 성공
        showAlert(title: "Success", message: "Welcome, \(user.nickname)!")
    }



    
}

//이건 임시에용..
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
