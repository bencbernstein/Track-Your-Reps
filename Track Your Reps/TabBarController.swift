///
/// TabBarController.swift
///

import UIKit


class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // USA State (ex. NY)
    var userState: String? {
        return UserDefaults.standard.string(forKey: "state")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = tabBarItem.title
        setupUser()
        setupViewControllers()
    }
    
    func setupUser() {
        guard let userState = userState else { onboardUser(); return }
        User.sharedInstance.state = userState
        User.sharedInstance.dataStore.members = CongressMember.all(for: userState)
        print("User state: \(User.sharedInstance.state)")
    }
    
    func onboardUser() {
        let onBoardVC = OnBoardViewController()
        parent?.present(onBoardVC, animated: true, completion: nil)
    }
}


typealias ViewControllersInitializer = TabBarController
extension ViewControllersInitializer {
    
    func setupViewControllers() {
        self.viewControllers = [createFeedTableView(), createRepsTableView()]
    }
    
    func createFeedTableView() -> FeedTableVC {
        let feedTableView = FeedTableVC()
        let feedBarItem = UITabBarItem(title: "Feed", image: nil, selectedImage: nil)
        feedTableView.tabBarItem = feedBarItem
        return feedTableView
    }
    
    func createRepsTableView() -> RepsTableVC {
        let repsTableView = RepsTableVC()
        let repsBarItem = UITabBarItem(title: "Reps", image: nil, selectedImage: nil)
        repsTableView.tabBarItem = repsBarItem
        return repsTableView
    }
}
