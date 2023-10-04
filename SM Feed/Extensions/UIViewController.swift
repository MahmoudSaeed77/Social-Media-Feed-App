//
//  UIViewController.swift
//  Reben
//
//  Created by Mahmoud Saeed on 19/07/2023.
//

import UIKit
import MapKit

extension UIViewController {
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    func buttonUI(sender: AppButton, animating: Bool) {
        if animating {
            sender.isEnabled = false
            sender.indicator.startAnimating()
        } else {
            sender.isEnabled = true
            sender.indicator.stopAnimating()
        }
    }
}
extension UIViewController {
    func isGoogleMapsInstalled() -> Bool {
        let googleMapsURLString = "comgooglemaps://"
        guard let googleMapsURL = URL(string: googleMapsURLString) else {
            return false
        }
        
        return UIApplication.shared.canOpenURL(googleMapsURL)
    }
    func directionAction(destenation: CLLocation) {
        
        let alert = UIAlertController(title: "Apps to show directions".localized, message: "Choose app to show your directions".localized, preferredStyle: .actionSheet)
        
        let googleAction = UIAlertAction(title: "Google Maps".localized, style: .default) { action in
            self.openURL(url: "comgooglemaps://?saddr=&daddr=\(destenation.coordinate.latitude),\(destenation.coordinate.longitude)&directionsmode=driving")
        }
        
        let appleAction = UIAlertAction(title: "Apple Maps".localized, style: .default) { action in
            let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: destenation.coordinate.latitude, longitude: destenation.coordinate.longitude), addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.openInMaps(launchOptions: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel) { cancel in
            alert.dismiss(animated: true, completion: nil)
        }
        
        if self.isGoogleMapsInstalled() {
            alert.addAction(googleAction)
            alert.addAction(appleAction)
        } else {
            alert.addAction(appleAction)
        }
        
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func openURL(url: String) {
        guard let url = URL(string: "\(url)") else { return }
        UIApplication.shared.open(url)
    }
}

protocol TimeDelegate {
    func getRemainingTime(time: String, didEnded: Bool)
}
extension UIViewController {
    func counter(validate: Bool, totalTime: Int, delegate: TimeDelegate?) {
        var text: String?
        var total = totalTime
        var t: Timer?
        
        t = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            text = self.timeFormatted(total) // will show timer
            if total != 0 {
                total -= 1  // decrease counter timer
                delegate?.getRemainingTime(time: text ?? "", didEnded: false)
            } else {
                timer.invalidate()
                delegate?.getRemainingTime(time: text ?? "", didEnded: true)
            }
            if !validate {
                t?.invalidate()
                t = nil
                return
            }
        })
        if !validate {
            t?.invalidate()
            t = nil
            return
        }
    }
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
}
protocol StatusBarAppearance {
    func setupStatusBar()
}

extension UITabBarController: StatusBarAppearance {
    func setupStatusBar() {
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = UIColor(named: "appColor")
        view.addSubview(statusBarView)
    }
}
class BaseViewController: UITabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = UIColor(named: "appColor")
        view.addSubview(statusBarView)
    }
}

extension UITabBarController {
    static func swizzleViewWillAppear() {
        let originalSelector = #selector(viewWillAppear(_:))
        let swizzledSelector = #selector(swizzledViewWillAppear(_:))

        guard let originalMethod = class_getInstanceMethod(UIViewController.self, originalSelector),
              let swizzledMethod = class_getInstanceMethod(UIViewController.self, swizzledSelector) else {
            return
        }

        method_exchangeImplementations(originalMethod, swizzledMethod)
    }

    @objc private func swizzledViewWillAppear(_ animated: Bool) {
        swizzledViewWillAppear(animated)
        setupStatusBar()
    }
}
