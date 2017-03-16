///
/// OnboardVC.swift
///

import UIKit


class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerView = UIPickerView()
    let states = ["AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
    var submitButton = UIButton()
    var welcomeLabel = UILabel()
    
    var margins: UILayoutGuide {
        return view.layoutMarginsGuide
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func buttonAction(sender: UIButton!) {
        let state = states[pickerView.selectedRow(inComponent: 0)]
        UserDefaults.standard.set(state, forKey: "state")
        self.dismiss(animated: true) {
            User.sharedInstance.state = UserDefaults.standard.string(forKey: "state")!
            User.sharedInstance.fetchMembers()
            User.sharedInstance.fetchEvents()
        }
    }
    
}


// MARK: - PickerView Delegates and Data Sources
extension SettingsViewController {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row]
    }
}


// MARK: - Layout
extension SettingsViewController {
    
    func setupView() {
        self.view.backgroundColor = UIColor.white
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Set initial view to New York
        pickerView.selectRow(30, inComponent: 0, animated: true)
        
        setupWelcomeLabel()
        setupPickerView()
        setupSubmitButton()
        [welcomeLabel, pickerView,submitButton].forEach { self.view.addSubview($0)}
        setupConstraints()
    }
    
    func setupWelcomeLabel() {
        welcomeLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
        welcomeLabel.text = "Please select your state so we can find your reps."
        welcomeLabel.textAlignment = .center
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupPickerView() {
        pickerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupSubmitButton() {
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.blue, for: .normal)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    func setupConstraints() {
        welcomeLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
        welcomeLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        welcomeLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 80).isActive = true
        welcomeLabel.numberOfLines = 0
        
        pickerView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20).isActive = true
        pickerView.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.7).isActive = true
        pickerView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        
        submitButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        submitButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 20).isActive = true
    }
}
