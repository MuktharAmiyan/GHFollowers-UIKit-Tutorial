//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Mukthar Amiyan on 28/09/24.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
     
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    
    private func configureItem() {
        itemInfoViewOne.set(ItemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(ItemInfoType: .gist, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
}
