import Foundation
import UIKit

extension String {
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
