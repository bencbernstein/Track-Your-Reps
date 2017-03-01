//
//  ViewController.swift
//  Track Your Reps
//
//  Created by Benjamin Bernstein on 3/1/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let proPublicaAPI = ProPublica()
        proPublicaAPI.houseCall { (members) in
            print("results are \(members)")
        }
        
    }


}

