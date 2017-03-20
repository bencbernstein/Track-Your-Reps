//
//  NavBar.swift
//  Track Your Reps
//
//  Created by Benjamin Bernstein on 3/16/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import UIKit

extension UITableViewController {
    
    func navComponents(title: String) {
        let settingsButton = UIButton(type: .custom)
        settingsButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        settingsButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        settingsButton.setImage(#imageLiteral(resourceName: "Marker"), for: .normal)
        // TODO: Make this our 'selected' color when final icon
        settingsButton.setImage(#imageLiteral(resourceName: "Marker"), for: .selected)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: settingsButton)
        
        if title == "Home" {
            let logo = #imageLiteral(resourceName: "Icon")
            let imageView = UIImageView(image:logo)
            self.navigationItem.titleView = imageView
        } else {
            navigationItem.title = title
        }
        
        navigationController?.navigationBar.tintColor = Palette.black.color
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func openSettings() {
        self.present(SettingsViewController(), animated: true, completion: nil)
    }
}
