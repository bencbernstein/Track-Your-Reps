import UIKit


class TabBarController: UITabBarController, UITabBarControllerDelegate, OnBoardDelegate {
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = tabBarItem.title
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        onBoardIfNeeded()
        setupViewControllers()
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


typealias OnBoarding = TabBarController
extension OnBoarding {

    func onBoardIfNeeded() {
        if let state = defaults.string(forKey: "state")  {
            print("User's state is set as \(state)")
        } else {
            let onBoardVC = OnBoardViewController()
            onBoardVC.delegate = self
            self.present(onBoardVC, animated: true, completion: nil)
        }
    }
    
    func StateResponse(state: String) {
        defaults.set(state, forKey: "state")
        print("set state response to \(state)")
    }
}
