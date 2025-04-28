//
//  HistoryViewController.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import UIKit
import SnapKit

class HistoryViewController: UIViewController {
    
    private let historyLabel = UILabel()
    private let underlineView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        historyLabel.text = "History"
        historyLabel.font = UIFont.boldSystemFont(ofSize: 32)
        
        [
            historyLabel,
            underlineView
        ].forEach { view.addSubview($0) }
        
        historyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(30)
        }
        
        underlineView.backgroundColor = .black
        underlineView.snp.makeConstraints {
            $0.top.equalTo(historyLabel.snp.bottom).offset(3)
            $0.leading.equalTo(historyLabel.snp.leading)
            $0.trailing.equalTo(historyLabel.snp.trailing)
            $0.height.equalTo(1)
        }
    }
}
