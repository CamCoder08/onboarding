////
////  LoginViewController.swift
////  onboarding
////
////  Created by ByonJoonYoung on 4/28/25.
////
//

//  LoginViewController.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    
    // UI 요소
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome onBoard !"
        label.font = UIFont(name: "Nunito-Light",size: 24)
        label.textAlignment = .center
        return label
    }()
    
    private let idLabel = FormLabel(text: "ID")
    private let idTextField = CustomTextField(placeholder: "Enter id ...")
    
    private let passwordLabel = FormLabel(text: "Password")
    private let passwordTextField = CustomTextField(placeholder: "Enter password ...", isSecure: true)
    
    private let naver = UIImageView()
    private let kakao = UIImageView()
    private let gmail = UIImageView()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = UIFont(name: "Nunito-SemiBold",size: 24)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up?", for: .normal)
        button.titleLabel?.font = UIFont(name: "Nunito-Light",size: 16)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
//    private let snsStackView: UIStackView = {
//        let icons = ["kakao", "naver", "mail"] // <- Assets에 추가한 이미지 이름
//        let views = icons.map { UIImage(named: $0) }.compactMap { image -> UIImageView? in
//            let iv = UIImageView(image: image)
//            iv.contentMode = .scaleAspectFit
//            iv.snp.makeConstraints { $0.width.height.equalTo(40) }
//            return iv
//        }
//        let stack = UIStackView(arrangedSubviews: views)
//        stack.axis = .horizontal
//        stack.spacing = 30
//        stack.alignment = .center
//        return stack
//    }()
    
    // 생명주기

    override func viewDidLoad() {
        
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0.937, green: 0.525, blue: 0.729, alpha: 1.0) // #EF86BA
        
        naver.image = UIImage(named: "naver")
        kakao.image = UIImage(named: "kakao")
        gmail.image = UIImage(named: "mail")
        
        // 회원가입 버튼 연결
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
            
        // 로그인 버튼 연결
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        if let user = UserManager.shared.currentUser {
            idTextField.text = user.id
            passwordTextField.text = user.password
        }

        // 로그인 입력값 자동 입력
        idTextField.text = UserDefaults.standard.string(forKey: "LastLoginID")
        passwordTextField.text = UserDefaults.standard.string(forKey: "LastLoginPassword")


        setupLayout()
    }
    
    // 레이아웃 설정
    private func setupLayout() {
        [logoImageView, welcomeLabel,
         idLabel, idTextField,
         passwordLabel, passwordTextField,
         loginButton, signUpButton, /*snsStackView*/].forEach { view.addSubview($0) }
        
        view.addSubview(naver)
        view.addSubview(kakao)
        view.addSubview(gmail)
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(100)
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
         loginButton, signUpButton, /*snsStackView*/].forEach { view.addSubview($0) }

        signUpButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(13)
            $0.centerX.equalToSuperview()
        }
        
        naver.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(98)
            $0.height.equalTo(46)
            $0.width.equalTo(46)
        }
        
        kakao.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(46)
            $0.width.equalTo(46)
        }
        
        gmail.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).offset(30)
            $0.leading.equalTo(kakao.snp.trailing).offset(34)
            $0.height.equalTo(39)
            $0.width.equalTo(46)
        }
    }
    
    @objc private func signUpButtonTapped() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc private func loginButtonTapped() {
        let enteredID = idTextField.text ?? ""
        let enteredPassword = passwordTextField.text ?? ""

        switch UserManager.shared.login(id: enteredID, password: enteredPassword) {
        case .idNotFound:
            showAlert(title: "Login Failed", message: "존재하지 않는 ID입니다.")
        case .wrongPassword:
            showAlert(title: "Login Failed", message: "비밀번호가 일치하지 않습니다.")
        case .success(let user):
            showAlert(title: "Success", message: "Welcome, \(user.nickname)!") { [weak self] in
                // 탭바 컨트롤러로 루트 변경
                let tabBarController = TabBarController()
                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = scene.windows.first {
                    window.rootViewController = tabBarController
                    window.makeKeyAndVisible()
                }
            }
        }
    }


    private func switchToMainApp() {
        let sceneDelegate = UIApplication.shared.connectedScenes
            .first?.delegate as? SceneDelegate

        let tabBarController = TabBarController()
        sceneDelegate?.window?.rootViewController = tabBarController
        sceneDelegate?.window?.makeKeyAndVisible()
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
