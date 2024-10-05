//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Mukthar Amiyan on 21/09/24.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholderImage : UIImage = .avatarPlaceholder

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(urlString: String){
        self.init(frame: .zero)
        downloadImage(from: urlString)
    }
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
     func downloadImage(from urlString: String) {
        NetworkManager.shared.downloadImage(from: urlString) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
    
}

