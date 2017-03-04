//
//  RepTableViewCell.swift
//  Track Your Reps
//
//  Created by Benjamin Bernstein on 3/4/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import UIKit

class RepTableViewCell: UITableViewCell {

    let repImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    let repNameLabel = UILabel()
    let repContactLabel = UILabel()
    
    static let reuseID = "repcell"

    var hasAddedConstraints = false
    
    // MARK: Initalizers
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if !hasAddedConstraints {
            let marginGuide = contentView.layoutMarginsGuide
            
            // configure titleLabel
            contentView.addSubview(repImage)
            contentView.addSubview(repNameLabel)
            contentView.addSubview(repContactLabel)
   
            repImage.translatesAutoresizingMaskIntoConstraints = false
            repImage.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
            repImage.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
            repImage.trailingAnchor.constraint(equalTo: repNameLabel.leadingAnchor).isActive = true
//            repImage.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
            repImage.image = #imageLiteral(resourceName: "kirsten_gillibrand")
            repImage.clipsToBounds = true
            repImage.backgroundColor = UIColor.red

            repNameLabel.translatesAutoresizingMaskIntoConstraints = false
            repNameLabel.leadingAnchor.constraint(equalTo: repImage.leadingAnchor).isActive = true
            repNameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
            repNameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
            repNameLabel.numberOfLines = 0
            
            repNameLabel.font = UIFont(name: "Avenir-Book", size: 12)
            repNameLabel.textColor = UIColor.black
            
            repContactLabel.translatesAutoresizingMaskIntoConstraints = false
            repContactLabel.leadingAnchor.constraint(equalTo: repImage.trailingAnchor).isActive = true
            repContactLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
            repContactLabel.topAnchor.constraint(equalTo: repNameLabel.bottomAnchor).isActive = true
            repContactLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
            repContactLabel.numberOfLines = 0
            
            repContactLabel.font = UIFont(name: "Avenir-Book", size: 12)
            repContactLabel.textColor = UIColor.lightGray
            
            
        }
        hasAddedConstraints = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        repNameLabel.text = ""
        repContactLabel.text = ""
    }
    
}
