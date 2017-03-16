///
/// TabBarController.swift
///

import UIKit

protocol SetupViewControllersDelegate: class {
    func setupViewControllers()
}

class TabBarController: UITabBarController, UITabBarControllerDelegate, SetupViewControllersDelegate {
    
    var userState: String? {
        return UserDefaults.standard.string(forKey: "state")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        User.sharedInstance.delegate = self
        User.sharedInstance.state = userState!
        User.sharedInstance.fetchMembers()
        User.sharedInstance.fetchEvents()
        
        setupLayout()
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
        
        let eventsView = UINavigationController(rootViewController: eventsTableView())
        eventsView.navigationBar.barTintColor = Palette.pink.color

        let membersView = UINavigationController(rootViewController: membersTableView())
        membersView.navigationBar.barTintColor = Palette.pink.color
        
        self.viewControllers = [eventsView, membersView]
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
