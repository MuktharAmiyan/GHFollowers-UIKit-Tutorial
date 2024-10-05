//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by Mukthar Amiyan on 05/10/24.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    
    func removeExcessCell() {
        tableFooterView = UIView(frame: .zero)
    }
}
