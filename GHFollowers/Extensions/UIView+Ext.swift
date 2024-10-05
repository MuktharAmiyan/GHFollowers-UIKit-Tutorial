//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Mukthar Amiyan on 05/10/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview)
    }
}
