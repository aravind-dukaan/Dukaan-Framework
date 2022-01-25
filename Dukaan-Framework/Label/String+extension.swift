//
//  String+extension.swift
//  Dukaan
//
//  Created by Kartik on 25/01/21.
//

import Foundation
import UIKit

let base64Regex = "data:image\\/([a-zA-Z]*);base64,([^\\\"]*)"
public extension String {
    
    var isNotEmpty: Bool {
        return !isEmpty
    }
    
    var trim: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var urlEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
    
    func trimString() -> String {
        if self.hasSuffix(".00") {
            return String(self.dropLast(3))
        } else {
            return self
        }
    }
    
    var capitalizingFirstLetter: String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = (self as NSString).boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = (self as NSString).boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func attributedStringWithLineSpacing(_ space: CGFloat) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
        
        let attrString = NSMutableAttributedString(string: self)
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length))
        
        return attrString
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func attributedString(with lineHeight: CGFloat, font: UIFont, textColor: UIColor, alignment: NSTextAlignment = .natural, linebreakMode: NSLineBreakMode = .byTruncatingTail) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = linebreakMode
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0,
                                                     length: attributedString.length))
        
        attributedString.addAttribute(NSAttributedString.Key.font,
                                      value: font,
                                      range: NSRange(location: 0,
                                                     length: attributedString.length))
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: textColor,
                                      range: NSRange(location: 0,
                                                     length: attributedString.length))
        
        attributedString.addAttribute(NSAttributedString.Key.baselineOffset,
                                      value: (lineHeight - font.lineHeight)/4,
                                      range: NSRange(location: 0,
                                                     length: attributedString.length))
        
        return attributedString
    }
    
    func asAttributedString(attributes: [NSAttributedString.Key: Any]? = nil) -> NSAttributedString {
        NSAttributedString(string: self, attributes: attributes)
    }
    
    func attributedString(_ font: UIFont, _ color: UIColor, _ text: String) -> NSMutableAttributedString {
        var attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "")
        attributeString =  NSMutableAttributedString(string: text)
        attributeString.addAttributes([NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font], range: NSRange(location: 0, length: attributeString.length))
        return attributeString
    }
    
    func attributedString(_ font: UIFont, _ color: UIColor) -> NSMutableAttributedString {
        var attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "")
        attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttributes([NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font], range: NSRange(location: 0, length: attributeString.length))
        return attributeString
    }
    
    func containsUpperCase() -> Bool {
        let regex  = ".*[A-Z]+.*"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: self)
    }
    
    func containsLowerCase() -> Bool {
        let regex  = ".*[a-z]+.*"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: self)
    }
    
    func containsNumber() -> Bool {
        let regex  = ".*[0-9]+.*"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: self)
    }
    
    func containsSpecialCharacter() -> Bool {
        let regex  = ".*[ !\"\\\\#$%&'\\(\\)\\*+,\\-\\./:;<=>?@\\[\\]^_`\\{|\\}~]"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: self)
    }
    
    var isHttpUrl: Bool {
        let isUrl = self.hasPrefix("http") || self.hasPrefix("https")
        return isUrl
    }
    
    var formatedPlanName: String {
        return self == dukaanPremiumTitle ? "Premium" : self
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Element {
        return self[index(startIndex, offsetBy: offset)]
    }
    subscript(_ range: Range<Int>) -> SubSequence {
        return prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }
    subscript(range: ClosedRange<Int>) -> SubSequence {
        return prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }
    subscript(range: PartialRangeThrough<Int>) -> SubSequence {
        return prefix(range.upperBound.advanced(by: 1))
    }
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence {
        return prefix(range.upperBound)
    }
    subscript(range: PartialRangeFrom<Int>) -> SubSequence {
        return suffix(Swift.max(0, count - range.lowerBound))
    }
}

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}

extension Data {
    private static let mimeTypeSignatures: [UInt8: String] = [
        0xFF: "image/jpeg",
        0x89: "image/png",
        0x47: "image/gif",
        0x49: "image/tiff",
        0x4D: "image/tiff",
        0x25: "application/pdf",
        0xD0: "application/vnd",
        0x46: "text/plain"
    ]
    
    var mimeType: String {
        var char: UInt8 = 0
        copyBytes(to: &char, count: 1)
        return Data.mimeTypeSignatures[char] ?? "application/octet-stream"
    }
}

extension NSRegularExpression {
    convenience init(pattern: String) {
        // swiftlint:disable:next force_try
        try! self.init(pattern: pattern, options: [])
    }
}

extension String {
    
    var isValidGST: Bool {
        return isMatching(expression: NSRegularExpression(pattern: "^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$"))
    }
    
    var isValidEmail: Bool {
        return isMatching(expression: NSRegularExpression(pattern: "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$"))
    }
    
    var isValidDomain: Bool {
            // "^[a-zA-Z0-9][-a-zA-Z0-9]+[a-zA-Z0-9].[a-z]{2,3}(.[a-z]{2,3})?(.[a-z]{2,3})?$"
            let exp = "^(?!-)[A-Za-z0-9-]+([\\-\\.]{1}[a-z0-9]+)*\\.[A-Za-z]{2,6}$"  // "^(www\.)?[-a-zA-Z0-9@:%._~#=]{1,256}\.[a-zA-Z0-9()]{1,16}\b([-a-zA-Z0-9()@:%_.~#?&//=]*)"
            return isMatching(expression: NSRegularExpression(pattern: exp))
        }
    
    // MARK: - Private
    private func isMatching(expression: NSRegularExpression) -> Bool {
        return expression.numberOfMatches(in: self, range: NSRange(location: 0, length: count)) > 0
    }
    
    var isValidURL: Bool {
        guard !contains("..") else { return false }
        
        let head     = "((http|https)://)?([(w|W)]{3}+\\.)?"
        let tail     = "\\.+[A-Za-z]{2,3}+(\\.)?+(/(.)*)?"
        let urlRegEx = head+"+(.)+"+tail
        
        let urlTest = NSPredicate(format: "SELF MATCHES %@", urlRegEx)
        
        return urlTest.evaluate(with: trimmingCharacters(in: .whitespaces))
    }
}

extension String {
    var containsSpecialCharacters: Bool {
        let regex = ".*[^A-Za-z0-9].*"
        let testString = NSPredicate(format: "SELF MATCHES %@", regex)
        return testString.evaluate(with: self)
    }
    
    func underLine(_ color: UIColor = .black12, _ font: UIFont = .heading5) -> NSAttributedString {
        let textRange = NSRange(location: 0, length: self.count)
        let originalText = self.attributedString(font, color)
        var finalAttributedString = NSMutableAttributedString(string: "")
        finalAttributedString.append(originalText)
        finalAttributedString = finalAttributedString.lineSpacingAlone(1)
        let underlineAttributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: color
        ]
        finalAttributedString.addAttributes(underlineAttributes, range: textRange)
        return finalAttributedString
    }
}

extension NSAttributedString {
    func attributedString(with lineHeight: CGFloat) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
    
    func lineSpacingAlone(_ space: CGFloat, _ align: NSTextAlignment = .left) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
        paragraphStyle.alignment = align

        let attrString = NSMutableAttributedString(attributedString: self)
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length))
        return attrString
    }
}

extension String {
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var htmlToMutableAttributedString: NSMutableAttributedString? {
        guard let data = data(using: .utf8, allowLossyConversion: true) else { return nil }
        do {
            return try NSMutableAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil)
        } catch {
            return nil
        }
    }

    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension String {
    func replace(string: String, replacement: String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
    
    func removeEmptySpaces() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var stringByRemovingWhitespaces: String {
        let components = components(separatedBy: .whitespacesAndNewlines)
        return components.joined(separator: "")
    }
    var removeCommas: String {
        return replacingOccurrences(of: ",", with: "")
    }
}

extension String {
    var colorFromHex: UIColor {
        return UIColor(hex: self)
    }
}

extension String {
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"

        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)

        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }

        return (self as NSString).substring(with: result.range)
    }
}

extension String {
    func matches(for regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
            return results.map {
                // self.substring(with: Range($0.range, in: self)!)
                String(self[Range($0.range, in: self)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func base64ToImage() -> UIImage? {
        if let url = URL(string: self), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            return image
        }
        return nil
    }
}

extension URL {
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
    
    func expandURLWithCompletionHandler(completionHandler: @escaping (URL?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: self, completionHandler: { _, response, _ in
            if let expandedURL = response?.url {
                completionHandler(expandedURL)
            }
        })
        task.resume()
    }
    
    var isPDFUrl: Bool {
        return self.pathExtension == "pdf"
    }
    
    var isXlsUrl: Bool {
        return self.pathExtension == "xls"
    }
}
