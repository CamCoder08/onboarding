//
//  HistoryViewController.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import UIKit
import SnapKit

class HistoryViewController: UIViewController, UITableViewDataSource {

    var histories: [HistoryDisplayModel] = []

    private let historyLabel = UILabel()
    private let underlineView = UIView()
    private let tableView = UITableView()
    
//    var histories:[HistoryDisplayModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        histories = HistoryDisplayManager.manager.display()
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return histories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as? HistoryTableViewCell else {
            return UITableViewCell()
        }

        let item = histories[indexPath.row]
        cell.configure(
            code: histories[indexPath.row].deviceId,
            date: histories[indexPath.row].returnTime,
            price: histories[indexPath.row].fee
        )

        return cell
    }

    
    private func configureUI() {
        view.backgroundColor = .white
        
        [
            historyLabel,
            underlineView,
            tableView
        ].forEach { view.addSubview($0) }
        
        historyLabel.text = "History"
        historyLabel.font = UIFont(name: "Nunito-Semibold", size: 32)
        underlineView.backgroundColor = .black
        
        tableView.dataSource = self
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "HistoryCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.rowHeight = 120

    }
    
    private func setupConstraints() {
        historyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(30)
        }

        underlineView.snp.makeConstraints {
            $0.top.equalTo(historyLabel.snp.bottom).offset(3)
            $0.leading.equalTo(historyLabel.snp.leading)
            $0.trailing.equalTo(historyLabel.snp.trailing)
            $0.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(underlineView.snp.bottom).offset(26)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

