//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by Mukthar Amiyan on 02/10/24.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemGreen
        self.viewControllers = [createSearchNC(),createFavoriteNC()]
    }
    
    func createSearchNC()-> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoriteNC()->UINavigationController {
        let favouriteListVC = FavoritesListVC()
        favouriteListVC.title = "Favorites"
        favouriteListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favouriteListVC)
    }
    
}
