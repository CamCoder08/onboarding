//
//  UIViewController+ExtensionsViewController.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import UIKit

// UIViewController를 확장하여, 경고창 표시와 키보드 숨기기 기능을 추가
extension UIViewController {

    // 제목과 메시지를 받아서 간단한 Alert를 띄워주는 함수
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }

    // 화면 아무 곳이나 탭하면 키보드를 숨기는 기능을 추가하는 함수
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    // 키보드를 내리는 실제 동작을 담당하는 함수
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

/*
 사용 예시

 // Alert 띄우기
 showAlert(title: "오류", message: "아이디를 입력해주세요.")

 // 키보드 숨기기 기능 활성화 (보통 viewDidLoad에서 호출)
 hideKeyboardWhenTappedAround()

 */


/*
 이 파일은 UIViewController에 공통적으로 필요한 기능을 추가한 확장 파일입니다.
 Alert(경고창) 띄우기와, 화면을 터치했을 때 키보드를 내리는 기능을 쉽게 사용할 수 있게 해줍니다.
 모든 ViewController에서 재사용할 수 있도록 만들어두었습니다.
 새로 만든 화면에서 Alert를 띄워야 하거나, 키보드를 숨기고 싶을 때 바로 사용하시면 됩니다.
 */


