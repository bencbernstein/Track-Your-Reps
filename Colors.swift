///
///  Colors.swift
///

import UIKit
import Foundation

enum Palette {
    case pink, blue, red, green, grey, darkgrey, white, black
    
    var color: UIColor {
        switch self {
        case .pink: return UIColor(hex: 0xFFDCE5)
        case .blue: return UIColor(hex: 0x2D9CDB)
        case .red: return UIColor(hex: 0xEB5757)
        case .green: return UIColor(hex: 0x27AE60)
        case .grey: return UIColor(hex: 0xA5A5A5)
        case .white: return UIColor(hex: 0xffffff)
        case .darkgrey: return UIColor(hex: 0x4F4F4F)
        case .black: return UIColor(hex: 0x000000)
        }
    }
}

extension UIColor {
    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
    class func forGradient(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
    
}

extension CongressMember {
    
    func partyColor() -> UIColor {
        switch self.party {
        case "R":
            return Palette.red.color
        case "D":
            return Palette.blue.color
        default:
            return Palette.green.color
        }
    }
}

extension Event {
    
    func positionColor() -> UIColor {
        switch self.position {
        case "Yes":
            return Palette.blue.color
        case "No":
            return Palette.red.color
        default:
            return Palette.green.color
        }
    }
}


func determineBackgroundColor(_ text:String) -> UIColor {
    if text.contains("Education") {
        return Palette.green.color
    } else if text.contains("Natural") {
        return Palette.blue.color
    } else if text.contains("Labor") {
        return Palette.red.color
    } else {
        return Palette.darkgrey.color
    }
}

func positionImage(_ Event: Event) -> UIImage {
    switch Event.position {
    case "Yes":
        return #imageLiteral(resourceName: "Check")
    case "No":
        return #imageLiteral(resourceName: "X")
    default:
        // TODO: - Images for other vote types
        return #imageLiteral(resourceName: "Check")
    }
}

func multiColorText(textToColor: [(String, UIColor)], withImage: UIImage?, at index: Int?) -> NSMutableAttributedString {
    let baseString = textToColor.map({ $0.0 }).joined(separator: " ")
    let mutableString = NSMutableAttributedString(string: baseString)
    for (str, color) in textToColor {
        let range = baseString.range(of: str,
                                     options: NSString.CompareOptions.literal,
                                     range: baseString.startIndex..<baseString.endIndex,
                                     locale: nil)
        guard let index = range?.lowerBound else { continue }
        let intValue = baseString.distance(from: baseString.startIndex, to: index)
        let strLength = str.characters.count
        mutableString.addAttribute(NSForegroundColorAttributeName, value: color, range: NSRange(location: intValue, length: strLength))
    }
    if let image = withImage, let index = index {
        let nsImage = NSTextAttachment()
        nsImage.image = image
        nsImage.bounds = CGRect(x: 0, y: -3, width: 18, height: 18)
        let attrString = NSAttributedString(attachment: nsImage)
        mutableString.insert(attrString, at: index)
    }
    return mutableString
}
