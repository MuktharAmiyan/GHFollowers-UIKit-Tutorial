//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Mukthar Amiyan on 05/10/24.
//

import UIKit

extension UIView {
    
    func pinToEdge(of superView: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo:superView.bottomAnchor),
        ])
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview)
    }
}
