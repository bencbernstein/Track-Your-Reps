///
/// TabBarController.swift
///

import UIKit

protocol SetupViewControllersDelegate: class {
    func setupViewControllers()
}

class TabBarController: UITabBarController, UITabBarControllerDelegate, SetupViewControllersDelegate {
    
    // USA State (ex. NY)
    var userState: String? {
        return UserDefaults.standard.string(forKey: "state")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = UIColor.white
        tabBar.barTintColor = Palette.pink.color
        tabBar.tintColor = .black
        
        tabBar.itemPositioning = UITabBarItemPositioning.centered
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black], for: .selected)
        setupUser()
    }
    
    func setupUser() {
        guard let userState = userState else { onboardUser(); return }
        User.sharedInstance.delegate = self
        User.sharedInstance.state = userState
        User.sharedInstance.fetchMembers()
        User.sharedInstance.fetchEvents()
    }
    
    func onboardUser() {
        let onBoardVC = OnBoardViewController()
        parent?.present(onBoardVC, animated: true, completion: nil)
    }
}


typealias ViewControllersInitializer = TabBarController
extension ViewControllersInitializer {
    
    func setupViewControllers() {
        self.viewControllers = [feedTableView(), repsTableView()]
    }
    
    func feedTableView() -> FeedTableVC {
        let feedTableView = FeedTableVC()
        let feedBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "Home"), selectedImage: nil)
        feedTableView.tabBarItem = feedBarItem
        return feedTableView
    }
    
    func repsTableView() -> RepsTableVC {
        let repsTableView = RepsTableVC()
        let repsBarItem = UITabBarItem(title: "Reps", image: #imageLiteral(resourceName: "Reps"), selectedImage: nil)
        repsTableView.tabBarItem = repsBarItem
        return repsTableView
    }
}
