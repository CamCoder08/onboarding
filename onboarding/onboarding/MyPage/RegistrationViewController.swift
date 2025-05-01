//
//  RegistrationViewController.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import UIKit
import SnapKit

class RegistrationViewController: UIViewController {
    
    private let registerLabel = UILabel()
    private let underlineView2 = UIView()
    private let tableView2 = UITableView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        setupConstraints()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        [
            registerLabel,
            underlineView2,
            tableView2
        ].forEach { view.addSubview($0) }
        
        registerLabel.text = "Registration"
        registerLabel.font = UIFont(name: "Nunito-Semibold", size: 32)
        underlineView2.backgroundColor = .black
        
        tableView2.dataSource = self
        tableView2.register(RegistrationTableViewCell.self, forCellReuseIdentifier: "RegisterCell")
        tableView2.separatorStyle = .none
        tableView2.backgroundColor = .white
        tableView2.rowHeight = 120

    }
    
    private func setupConstraints() {
        registerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(30)
        }

        underlineView2.snp.makeConstraints {
            $0.top.equalTo(registerLabel.snp.bottom).offset(3)
            $0.leading.equalTo(registerLabel.snp.leading)
            $0.trailing.equalTo(registerLabel.snp.trailing)
            $0.height.equalTo(1)
        }
        
        tableView2.snp.makeConstraints {
            $0.top.equalTo(underlineView2.snp.bottom).offset(26)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

extension RegistrationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterCell", for: indexPath) as? RegistrationTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(code: "{ 303448 }!", date: "2025.04.38 Monday", address: "부산광역시 해운대구 좌동")
        return cell
    }
}

   
