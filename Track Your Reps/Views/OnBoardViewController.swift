//
//  OnBoardViewController.swift
//  Track Your Reps
//
//  Created by Benjamin Bernstein on 3/7/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import UIKit

class OnBoardViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var welcomeLabel = UILabel()
    var submitButton = UIButton()
    var pickerView = UIPickerView()
    let statePickerData = ["AL", "AK", "AS", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FM", "FL", "GA", "GU", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MH", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "MP", "OH", "OK", "OR", "PW", "PA", "PR", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VI", "VA", "WA", "WV", "WI", "WY", "AE", "AA", "AP"]
    
    var delegate: OnBoardDelegate?
    
    var marginsGuide: UILayoutGuide {
        return view.layoutMarginsGuide
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonAction(sender: UIButton!) {
        let state = statePickerData[pickerView.selectedRow(inComponent: 0)]
        self.delegate?.StateResponse(state: state)
        self.dismiss(animated: true, completion: nil)

    }
    
}

//MARK: - PickerView Delegates and Data Sources

extension OnBoardViewController {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statePickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return statePickerData[row]
    }
}

extension OnBoardViewController {
    
    func setUpView() {
        self.view.backgroundColor = UIColor.white
        pickerView.delegate = self
        pickerView.dataSource = self
        setUpWelcomeLabel()
        setUpPickerView()
        setUpSubmitButton()
        [welcomeLabel, pickerView,submitButton].forEach { self.view.addSubview($0)}
        setUpConstraints()
        
    }
    
    func setUpWelcomeLabel() {
        welcomeLabel.font = UIFont(name: "Avenir-DemiBold", size: 16)
        welcomeLabel.text = "Please select your state so we can find your reps."
        welcomeLabel.textAlignment = .center
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setUpPickerView() {
        pickerView.translatesAutoresizingMaskIntoConstraints = false
    
    }

    func setUpSubmitButton() {
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(UIColor.blue, for: .normal)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    
    }
    
    func setUpConstraints() {
        welcomeLabel.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor, constant: 20).isActive = true
        welcomeLabel.centerXAnchor.constraint(equalTo: marginsGuide.centerXAnchor).isActive = true
        welcomeLabel.topAnchor.constraint(equalTo: marginsGuide.topAnchor, constant: 80).isActive = true
        welcomeLabel.numberOfLines = 0
        
        pickerView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20).isActive = true
        pickerView.widthAnchor.constraint(equalTo: marginsGuide.widthAnchor, multiplier: 0.7).isActive = true
        pickerView.centerXAnchor.constraint(equalTo: marginsGuide.centerXAnchor).isActive = true
      
        submitButton.centerXAnchor.constraint(equalTo: marginsGuide.centerXAnchor).isActive = true
        submitButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 20).isActive = true
        


        }
}


protocol OnBoardDelegate {
    func StateResponse(state: String)
  
}





    
   
