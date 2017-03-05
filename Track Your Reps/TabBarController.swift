import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = tabBarItem.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupViewControllers()
    }
}


// MARK: - View Controllers

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
