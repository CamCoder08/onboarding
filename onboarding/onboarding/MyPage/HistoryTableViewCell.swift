//
//  HistoryTableViewCell.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import UIKit
import SnapKit

class HistoryTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    private let codeLabel = UILabel()
    private let dateLabel = UILabel()
    private let priceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(containerView)

        
        containerView.addSubview(codeLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(priceLabel)

        codeLabel.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        dateLabel.font = UIFont(name: "NotoSansKR-Regular", size: 13)
        priceLabel.font = UIFont(name: "NotoSansKR-Regular", size: 14)

        containerView.backgroundColor = UIColor(red: 0.96, green: 0.98, blue: 1, alpha: 1.0)
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
    }

    
    private func setupConstraints() {
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        codeLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(12)
        }
        
        dateLabel.snp.makeConstraints {
            $0.bottom.equalTo(codeLabel.snp.bottom)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().offset(-30)
        }
    }
    
    func configure(code: String, date: String, price: String) {
        codeLabel.text = code
        dateLabel.text = date
        priceLabel.text = price
    }
}
