//
//  TabBarControllerViewController.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import UIKit
import SnapKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setValue(CustomTabBar(), forKey: "tabBar")
        tabBar.tintColor = .white // 활성화된 탭 아이콘과 텍스트 색상
        tabBar.unselectedItemTintColor = .white // 비활성화된 탭 아이콘과 텍스트 색상

        tabBar.backgroundColor = UIColor.gray.withAlphaComponent(0.9)

    }

    private func setupTabBar() {
        let homeViewController = HomeViewController()
//        let brandViewController = BrandViewController()
        let myPageViewController = MyPageViewController()

        homeViewController.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "map"),
            selectedImage: UIImage(systemName: "map.fill")
        )

//        brandViewController.tabBarItem = UITabBarItem(
//            title: "onBoard",
//            image: UIImage(systemName: "scooter"),
//            selectedImage: UIImage(systemName: "scooter")
//        )

        myPageViewController.tabBarItem = UITabBarItem(
            title: "MyPage",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )

        viewControllers = [homeViewController, myPageViewController]
    }
}

private class BrandViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear


        let titleLabel = UILabel()
        titleLabel.text = "onBoard"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)

        view.addSubview(titleLabel)


        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

class CustomTabBar: UITabBar {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 100
        return sizeThatFits
    }
}
