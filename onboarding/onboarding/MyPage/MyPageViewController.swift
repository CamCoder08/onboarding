//
//  MyPageViewController.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import UIKit
import SnapKit

class MyPageViewController: UIViewController {
    
    private let logoImageView = UIImageView()
    private let introduceLabel = UILabel()
    private let nicknameLable = UILabel()
    private let statusImageView = UIImageView()
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let historyImageView = UIImageView()
    private let registerationImageView = UIImageView()
    private let TeamBannerImageView = UIImageView()
    
    private let logoutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupConstraints()
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor(hex: "#F6FAFF")
        
        // 뷰에 노출
        [
            logoImageView,
            introduceLabel,
            nicknameLable,
            statusImageView,
            scrollView,
        ].forEach { view.addSubview($0) }
        
        scrollView.addSubview(stackView)
        
        [
            historyImageView,
            registerationImageView,
            TeamBannerImageView,
            logoutButton
        ].forEach { stackView.addArrangedSubview($0) }
        
        // UI 설정
        logoImageView.image = UIImage(named: "MypageLogo")
        logoImageView.contentMode = .scaleAspectFit
        
        introduceLabel.text = "onBoarding과 함께, 매일이 작은 여행이 됩니다"
        introduceLabel.font = UIFont.systemFont(ofSize: 12)
        
        nicknameLable.text = "Hi, Suzie님!"
        nicknameLable.font = UIFont.boldSystemFont(ofSize: 35)
        
        statusImageView.image = UIImage(named: "StatusOff")
        statusImageView.contentMode = .scaleAspectFit
        
        scrollView.backgroundColor = .white

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 38
        
        historyImageView.image = UIImage(named: "HistoryButton")
        historyImageView.contentMode = .scaleAspectFit
        historyImageView.clipsToBounds = true
        
        registerationImageView.image = UIImage(named: "RegisterationButton")
        registerationImageView.contentMode = .scaleAspectFit
        registerationImageView.clipsToBounds = true
        
        TeamBannerImageView.image = UIImage(named: "TeamBanner")
        TeamBannerImageView.contentMode = .scaleAspectFit
        TeamBannerImageView.clipsToBounds = true
        
        logoutButton.setTitle("LOGOUT", for: .normal)
        logoutButton.setTitleColor(.black, for: .normal)
        logoutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        logoutButton.layer.borderColor = UIColor.black.cgColor
        logoutButton.layer.borderWidth = 0.5
        logoutButton.layer.cornerRadius = 10
    }
    
    private func setupConstraints() {
        
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(76)
            $0.leading.equalToSuperview().offset(31)
            $0.width.equalTo(138)
            $0.height.equalTo(34)
        }
        
        introduceLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(44)
            $0.leading.equalToSuperview().offset(35)
        }
        
        nicknameLable.snp.makeConstraints {
            $0.top.equalTo(introduceLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(31)
        }
        
        statusImageView.snp.makeConstraints {
            $0.bottom.equalTo(nicknameLable.snp.bottom)
            $0.trailing.equalToSuperview().offset(-41)
            $0.width.equalTo(64)
            $0.height.equalTo(36)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(nicknameLable.snp.bottom).offset(39)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-72)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 31, bottom: 0, right: 31))
        }
        
        historyImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.height.equalTo(150)
            $0.width.equalTo(332)
        }
        
        registerationImageView.snp.makeConstraints {
            $0.height.equalTo(150)
            $0.width.equalTo(332)
        }
        
        TeamBannerImageView.snp.makeConstraints {
            $0.height.equalTo(150)
            $0.width.equalTo(332)
        }
        
        logoutButton.snp.makeConstraints {
            $0.height.equalTo(63)
            $0.bottom.equalTo(scrollView.snp.bottom).offset(-19)
        }
    }
}
