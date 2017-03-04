//
//  ContainerViewController.swift
//  Track Your Reps
//
//  Created by Benjamin Bernstein on 3/4/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import UIKit

class ContainerViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = tabBarItem.title
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        let feedTab = FeedTableViewController()
        let feedBarItem = UITabBarItem(title: "Feed", image: nil, selectedImage: nil)
        
        feedTab.tabBarItem = feedBarItem
        
        let repsTab = RepsTableViewController()
        let repsBarItem = UITabBarItem(title: "Reps", image: nil, selectedImage: nil)
        
        repsTab.tabBarItem = repsBarItem
        
        self.viewControllers = [feedTab, repsTab]
    
        
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
    
    
}

