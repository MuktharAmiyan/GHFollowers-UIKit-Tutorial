//
//  GFButton.swift
//  GHFollowers
//
//  Created by Mukthar Amiyan on 07/09/24.
//

import UIKit

class GFButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius      = 10
        titleLabel?.textColor   = .white
        titleLabel?.font        = .preferredFont(forTextStyle: .headline)
    }
}
