///
/// ContactButtons.swift
///

import Foundation
import Social
import UIKit

class Twitter: UIImageView {
    let account: String
    
    var invalid: Bool {
        return account.noContent
    }
    
    init?(account: String, frame: CGRect) {
        
        self.account = account
        super.init(frame: frame)
        self.image = #imageLiteral(resourceName: "Twitter")
        
        if invalid {
            return nil
        }
        
        setupTap()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(twitterTapped(_:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    
    func twitterTapped(_ sender: UITapGestureRecognizer) {
        guard let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter) else { return }
        vc.setInitialText("@\(account)")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController!.present(vc, animated: true, completion: nil)
    }
}


class Phone: UIImageView {
    let number: URL
    
    init?(number: String, frame: CGRect) {

        if number.noContent {
            return nil
        }
        
        guard let url = URL(string: "telprompt://\(number)") else { return nil }
        self.number = url
        
        super.init(frame: frame)
        self.image = #imageLiteral(resourceName: "Phone")
        setupTap()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.phoneTapped(_:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    
    func phoneTapped(_ sender: UITapGestureRecognizer) {
        open(scheme: number)
    }
    
    func open(scheme: URL) {
        if #available(iOS 10, *) {
            UIApplication.shared.open(scheme, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(scheme)
        }
    }
}
