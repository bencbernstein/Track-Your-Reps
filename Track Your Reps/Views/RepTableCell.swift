import UIKit

class RepTableCell: UITableViewCell {
    
    let repImage = UIImageView()
    let repNameLabel = UILabel()
    let repContactLabel = UILabel()
    
    var views: [UIView] {
        return [repImage, repNameLabel, repContactLabel]
    }
    
    static let reuseID = "reps"
    
    var marginsGuide: UILayoutGuide {
        return contentView.layoutMarginsGuide
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Layout
extension RepTableCell {
    
    func setupView() {
        views.forEach { contentView.addSubview($0) }
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        setupRepNameLabel()
        setupRepContactLabel()
        setupRepImage()
    }
    
    func setupRepNameLabel() {
        repNameLabel.leadingAnchor.constraint(equalTo: repImage.trailingAnchor, constant: 10).isActive = true
        repNameLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor).isActive = true
        repNameLabel.topAnchor.constraint(equalTo: marginsGuide.topAnchor).isActive = true
        repNameLabel.numberOfLines = 0
        repNameLabel.font = UIFont(name: "Avenir-Book", size: 12)
        repNameLabel.textColor = .black
    }
    
    func setupRepContactLabel() {
        repContactLabel.leadingAnchor.constraint(equalTo: repNameLabel.leadingAnchor).isActive = true
        repContactLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor).isActive = true
        repContactLabel.topAnchor.constraint(equalTo: repNameLabel.bottomAnchor).isActive = true
        repContactLabel.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor).isActive = true
        repContactLabel.numberOfLines = 0
        repContactLabel.font = UIFont(name: "Avenir-Book", size: 12)
        repContactLabel.textColor = .lightGray
    }
    
    func setupRepImage() {
        repImage.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor).isActive = true
        repImage.topAnchor.constraint(equalTo: marginsGuide.topAnchor).isActive = true
        //repImage.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor).isActive = true
        repImage.widthAnchor.constraint(equalTo: marginsGuide.widthAnchor, multiplier: 0.15).isActive = true
        repImage.heightAnchor.constraint(equalTo: repImage.widthAnchor).isActive = true
        repImage.image = #imageLiteral(resourceName: "kirsten_gillibrand")
        repImage.backgroundColor = .red
    }
}
