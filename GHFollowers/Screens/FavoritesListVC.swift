//
//  FavoritesListVC.swift
//  GHFollowers
//
//  Created by Mukthar Amiyan on 07/09/24.
//

import UIKit

class FavoritesListVC: UIViewController {

    let tableView               = UITableView()
    var favourites: [Follower]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavourite()
    }
    
    func configureViewController() {
        view.backgroundColor    = .systemBackground
        title                   = "Favourites"
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame        = view.bounds
        tableView.rowHeight     = 80
        tableView.delegate      = self
        tableView.dataSource    = self
        
        tableView.register(FavouriteCell.self, forCellReuseIdentifier: FavouriteCell.reuseID)
    }
    
    
    func getFavourite() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
    
            switch result {
            case .success(let favourites):
                if favourites.isEmpty {
                    showEmptyStateView(with: "No favourites?\nAdd one on the follower screen.", in: self.view)
                } else {
                    self.favourites = favourites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
               
            case .failure(let failure):
                self.presentGFAlertOnMainTread(title: "Something went wrong", message: failure.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return favourites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteCell.reuseID) as! FavouriteCell
        let favourite = favourites[indexPath.row]
        cell.set(favourite: favourite)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favourite   = favourites[indexPath.row]
        let destVC      = FollowerListVC(username: favourite.login)
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let favourite   = favourites[indexPath.row]
        favourites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistenceManager.updateWith(favourite: favourite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.getFavourite()
                return
            }
            self.presentGFAlertOnMainTread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}
