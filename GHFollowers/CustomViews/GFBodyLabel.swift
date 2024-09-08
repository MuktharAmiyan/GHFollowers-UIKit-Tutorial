//
//  GFBodyLabel.swift
//  GHFollowers
//
//  Created by Mukthar Amiyan on 08/09/24.
//

import UIKit

class GFBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        textColor                   = .secondaryLabel
        font                        = .preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.75
        lineBreakMode               = .byTruncatingTail
    }

}
