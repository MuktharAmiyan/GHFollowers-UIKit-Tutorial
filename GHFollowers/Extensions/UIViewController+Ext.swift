//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Mukthar Amiyan on 08/09/24.
//

import UIKit

extension UIViewController {
    func presentGFAlertOnMainTread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title,message: message,buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
