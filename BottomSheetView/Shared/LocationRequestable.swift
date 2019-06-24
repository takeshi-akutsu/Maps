//
//  LocationRequestable.swift
//  BottomSheetView
//
//  Created by Takeshi Akutsu on 2019/06/25.
//  Copyright © 2019 Takeshi Akutsu. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationInfoRequestable: CLLocationManagerDelegate where Self: UIViewController {
    func requestLocationInfoIfNeeded()
    func requestAllowLocationInfo()
    var locationManager: CLLocationManager! { get set }
}

extension LocationInfoRequestable {
    func requestLocationInfoIfNeeded() {
        
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
        case .denied, .restricted:
            let alert = UIAlertController.init(title: "位置情報の取得を許可しましょう", message: "新しい募集や最新のお知らせを受け取るためにプッシュ通知を許可しましょう", preferredStyle: .alert)
            let ok = UIAlertAction.init(title: "設定する", style: .default) { [weak self] _ in
                self?.openAppSettings()
            }
            let no = UIAlertAction.init(title: "あとで", style: .default)
            alert.addAction(no)
            alert.addAction(ok)
            self.present(alert, animated: true)
        case .notDetermined:
            self.requestAuthorization()
        @unknown default:
            fatalError()
        }
    }
    
    func requestAllowLocationInfo() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.showAlreadyAuthorizedAlert()
        case .denied:
            self.openAppSettings()
        case .notDetermined:
            self.requestAuthorization()
        case .restricted:
            self.requestAuthorization()
        @unknown default:
            fatalError()
        }
    }
    
    private func showAlreadyAuthorizedAlert() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController.init(title: "既に位置情報の取得が許可されています", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
    
    private func openAppSettings() {
        DispatchQueue.main.async {
            if let url = URL.init(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
    private func requestAuthorization() {
        self.locationManager = CLLocationManager.init()
        
        DispatchQueue.main.async { [weak self] in
            self?.locationManager.requestWhenInUseAuthorization()
        }
    }
}
