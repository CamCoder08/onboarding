//
//  HomeViewController.swift
//  onboarding
//
//  Created by ByonJoonYoung on 4/28/25.
//

import UIKit
import SnapKit
import NMapsMap

class HomeViewController: UIViewController {

    // 네이버 지도 뷰를 프로퍼티로 선언
    private let mapView = NMFMapView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupMapView()
    }

    private func setupMapView() {
        view.addSubview(mapView)

        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


