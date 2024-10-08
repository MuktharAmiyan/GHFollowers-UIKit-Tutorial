//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Mukthar Amiyan on 28/09/24.
//

import UIKit

protocol GFFollowerItemVCDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

class GFFollowerItemVC: GFItemInfoVC {
    
   weak var delegate: GFFollowerItemVCDelegate!
    
    init(user: User, delegate: GFFollowerItemVCDelegate!) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    
    
    private func configureItem() {
        itemInfoViewOne.set(ItemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(ItemInfoType: .following, withCount: user.following)
        actionButton.set(color: .systemGreen, title: "Get Followers",image: SFSymbols.followers)
        
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
