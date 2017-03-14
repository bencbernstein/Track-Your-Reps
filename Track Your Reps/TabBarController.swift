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
        setupLayout()
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


// MARK: - Layout
extension TabBarController {
    
    func setupLayout() {
        view.backgroundColor = UIColor.white
        tabBar.barTintColor = Palette.pink.color
        tabBar.tintColor = .black
        tabBar.itemPositioning = UITabBarItemPositioning.centered
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black], for: .selected)
    }
}


typealias ViewControllersInitializer = TabBarController
extension ViewControllersInitializer {
    
    func setupViewControllers() {
        self.viewControllers = [eventsTableView(), membersTableView()]
    }
    
    func eventsTableView() -> EventsTableVC {
        let eventsTableView = EventsTableVC()
        let eventsBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "Home"), selectedImage: nil)
        eventsTableView.tabBarItem = eventsBarItem
        return eventsTableView
    }
    
    func membersTableView() -> MembersTableVC {
        let membersTableView = MembersTableVC()
        let membersBarItem = UITabBarItem(title: "Reps", image: #imageLiteral(resourceName: "Reps"), selectedImage: nil)
        membersTableView.tabBarItem = membersBarItem
        return membersTableView
    }
}
