//
//  Pickerview+Register.swift
//  onboarding
//
//  Created by ios_starter on 4/29/25.
//

//피커뷰 기초 형태
import UIKit

extension RegisterModalViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // 컬럼 수 -> 보통 1개
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 각 컬럼당 몇 개의 항목이 있는지
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerList.count
    }
    
    // 각 항목, 즉 row에 표시할 텍스트
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerList[row]
    }
}
