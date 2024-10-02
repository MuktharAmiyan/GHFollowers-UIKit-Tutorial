//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Mukthar Amiyan on 28/09/24.
//

import UIKit


class GFFollowerItemVC: GFItemInfoVC {
     
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    
    private func configureItem() {
        itemInfoViewOne.set(ItemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(ItemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
        
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
