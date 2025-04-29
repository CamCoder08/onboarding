//
//  LaunchScreen.swift
//  onboarding
//
//  Created by ios_starter on 4/28/25.
//

import UIKit
import SnapKit

class LaunchScreen: UIView {
    
    private let logo = UIImageView()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        logoSet()
        logoLayout()
        
        backgroundColor = .white
        
        logo.image = UIImage(named: "logo")
        logo.contentMode = .scaleAspectFit
        
    }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    private func logoSet() {
            addSubview(logo)
    }
    
    private func logoLayout() {
        logo.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(43)
            $0.width.equalTo(168)
        }
    }
        
}
