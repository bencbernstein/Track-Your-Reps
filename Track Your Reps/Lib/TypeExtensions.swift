import Foundation
import UIKit

extension String {
    
    // Converts 2017-03-14 00:00:00 UTC to Mar 14
    func kindDate() -> String {
        guard let date = self.components(separatedBy: " ").first else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale.init(identifier: "en_US")
        guard let dateObj = dateFormatter.date(from: date) else { return "" }
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: dateObj)
    }
    
    func toDate() -> Date? {
        guard let date = self.components(separatedBy: " ").first else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale.init(identifier: "en_US")
        guard let dateObj = dateFormatter.date(from: date) else { return nil }
        return dateObj
    }
    
    var noContent: Bool {
        return self == ""
    }

    var numbersOnly: String {
        return components(separatedBy: NSCharacterSet(charactersIn: "1234567890")
            .inverted)
            .joined(separator: "")
    }
    
    func trunc(length: Int, trailing: String? = "...") -> String {
        if self.characters.count > length {
            return self.substring(to: self.startIndex.advance(length, for: self)) + (trailing ?? "")
        } else {
            return self
        }
    }
}

extension String.Index{
    func advance(_ offset:Int, for string:String)->String.Index{
        return string.index(self, offsetBy: offset)
    }
}

extension UILabel {
    
    func setLineHeight(lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineHeight
            attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, (text as NSString).length))
            self.attributedText = attributeString
        }
    }
}

func multiColorText(textToColor: [(String, UIColor, UIFont)], withImage: UIImage?, at index: Int?) -> NSMutableAttributedString {
    let baseString = textToColor.map({ $0.0 }).joined(separator: " ")
    let mutableString = NSMutableAttributedString(string: baseString)
    for (str, color, font) in textToColor {
        let range = baseString.range(of: str,
                                     options: NSString.CompareOptions.literal,
                                     range: baseString.startIndex..<baseString.endIndex,
                                     locale: nil)
        guard let index = range?.lowerBound else { continue }
        let intValue = baseString.distance(from: baseString.startIndex, to: index)
        let strLength = str.characters.count
        mutableString.addAttribute(NSForegroundColorAttributeName, value: color, range: NSRange(location: intValue, length: strLength))
        mutableString.addAttribute(NSFontAttributeName, value: font, range: NSRange(location: intValue, length: strLength))
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


