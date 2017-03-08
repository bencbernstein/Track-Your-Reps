import UIKit

class RepTableCell: UITableViewCell {

    let repImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
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
        repNameLabel.translatesAutoresizingMaskIntoConstraints = false
        repNameLabel.leadingAnchor.constraint(equalTo: repImage.leadingAnchor).isActive = true
        repNameLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor).isActive = true
        repNameLabel.topAnchor.constraint(equalTo: marginsGuide.topAnchor).isActive = true
        repNameLabel.numberOfLines = 0
        repNameLabel.font = UIFont(name: "Avenir-Book", size: 12)
        repNameLabel.textColor = .black
    }
    
    func setupRepContactLabel() {
        repContactLabel.translatesAutoresizingMaskIntoConstraints = false
        repContactLabel.leadingAnchor.constraint(equalTo: repImage.trailingAnchor).isActive = true
        repContactLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor).isActive = true
        repContactLabel.topAnchor.constraint(equalTo: repNameLabel.bottomAnchor).isActive = true
        repContactLabel.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor).isActive = true
        repContactLabel.numberOfLines = 0
        repContactLabel.font = UIFont(name: "Avenir-Book", size: 12)
        repContactLabel.textColor = .lightGray
    }
    
    func setupRepImage() {
        repImage.translatesAutoresizingMaskIntoConstraints = false
        repImage.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor).isActive = true
        repImage.topAnchor.constraint(equalTo: marginsGuide.topAnchor).isActive = true
        repImage.trailingAnchor.constraint(equalTo: repNameLabel.leadingAnchor).isActive = true
        // repImage.image = #imageLiteral(resourceName: "kirsten_gillibrand")
        repImage.clipsToBounds = true
        repImage.backgroundColor = .red
    }
}
