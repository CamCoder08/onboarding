//
//  CustomTextField.swift
//  onboarding
//
//  Created by Suzie Kim on 4/29/25.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    init(placeholder: String, isSecure: Bool = false) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.isSecureTextEntry = isSecure
        self.borderStyle = .none
        self.translatesAutoresizingMaskIntoConstraints = false

        let underline = UIView()
        underline.backgroundColor = .black
        underline.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(underline)

        NSLayoutConstraint.activate([
            underline.heightAnchor.constraint(equalToConstant: 1),
            underline.leadingAnchor.constraint(equalTo: leadingAnchor),
            underline.trailingAnchor.constraint(equalTo: trailingAnchor),
            underline.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
