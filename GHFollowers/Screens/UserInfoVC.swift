//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Mukthar Amiyan on 22/09/24.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollower(for username: String)
}

class UserInfoVC: UIViewController {
    let scrollView          = UIScrollView()
    let contentView         = UIView()
    
    let headerView          = UIView()
    let itemViewOne         = UIView()
    let itemViewTwo         = UIView()
    let dateLabel           = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var username: String!
    weak var delegate: UserInfoVCDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        layoutUI()
        getUserInfo()
        
    }
    
    fileprivate func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    fileprivate func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdge(of: view)
        contentView.pinToEdge(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant:  600)
        ])

    }
    
    
    fileprivate func getUserInfo() {
        
        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: username)
                configureUIElements(with: user)
            } catch {
                if let gfError = error as? GFError {
                    presentGFAlert(title: "Something went wrong", message: gfError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultError()
                }
            }
        }
        
//        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let user):
//                DispatchQueue.main.async { self.configureUIElements(with: user) }
//            case .failure(let failure):
//                break
//               self.presentGFAlert(title: "Something went wrong", message: failure.rawValue, buttonTitle: "Ok")
//            }
//        }
    }
    
    fileprivate func configureUIElements(with user: User) {
        self.add(childVc: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVc: GFRepoItemVC(user: user,delegate: self), to: self.itemViewOne)
        self.add(childVc: GFFollowerItemVC(user: user,delegate:self), to: self.itemViewTwo)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToMonthYear())"
        
    }
    
    func layoutUI() {
        let padding: CGFloat    = 20.0
        let itemHeight: CGFloat = 140
        
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
       
        
        for itemView in itemViews {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -padding),
            ])
        }
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func add(childVc: UIViewController, to containerView: UIView){
        addChild(childVc)
        containerView.addSubview(childVc.view)
        childVc.view.frame = containerView.bounds
        childVc.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    

}
extension UserInfoVC: GFFollowerItemVCDelegate {
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlert(title: "No followers", message: "This user has no followers. What a shame 😞", buttonTitle: "So Sad")
            return
        }
        delegate.didRequestFollower(for: user.login)
        dismissVC()
    }
}

extension UserInfoVC: GFRepoItemVCDelegate {
    
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlert(title: "Invalid URL", message: "This url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }
}


 
