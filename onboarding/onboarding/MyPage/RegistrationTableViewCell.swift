//
//  RegistrationTableViewCell.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import UIKit
import SnapKit

class RegistrationTableViewCell: UITableViewCell {
    
    private let registerCell = UIView()
    private let registerCode = UILabel()
    private let registerDate = UILabel()
    private let registerAddress = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        // 테이블뷰는 순서 무척 중요
        // 반드시 먼저 superview에 있어야 함
        contentView.addSubview(registerCell)
        
        // registerCell 먼저 제약 설정하고
        registerCell.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }

        // 안에 들어갈 내용물 넣고
        registerCell.addSubview(registerCode)
        registerCell.addSubview(registerDate)
        registerCell.addSubview(registerAddress)

        // 내용물 제약 걸고
        registerCode.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(12)
        }

        registerDate.snp.makeConstraints {
            $0.bottom.equalTo(registerCode.snp.bottom)
            $0.trailing.equalToSuperview().offset(-20)
        }

        registerAddress.snp.makeConstraints {
            $0.top.equalTo(registerCode.snp.bottom).offset(20)
            $0.leading.equalTo(registerCode.snp.leading)
        }
        
        // 그러고 나서 폰트 등 세부 사항 적용
        registerCode.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        registerDate.font = UIFont(name: "NotoSansKR-Regular", size: 13)
        registerAddress.font = UIFont(name: "NotoSansKR-Light", size: 13)
        
        registerCell.backgroundColor = UIColor(red: 0.96, green: 0.98, blue: 1, alpha: 1.0)
        registerCell.layer.cornerRadius = 20
        registerCell.clipsToBounds = true
    }

    
    func configure(code: String, date: String, address: String) {
        registerCode.text = code
        registerDate.text = date
        registerAddress.text = address
    }
}

