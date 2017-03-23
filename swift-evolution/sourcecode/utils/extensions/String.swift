import UIKit

// MARK: - Enum Tag
enum Tag: String {
    case content = "content"
    case title = "title"
    case label = "label"
    case value = "value"
    case id = "id"
    
    func wrap(string: String) -> String {
        return "<\(self.rawValue)>\(string)</\(self.rawValue)>"
    }
}

// MARK: - String extension
extension String {
    /**
     Return a new line in text
     */
    static var newLine: String {
        return "\n"
    }
    
    /**
    Double space text
    */
    static var doubleSpace: String {
        return "  "
    }
    
    /**
     Wrap the text using tag
     ````
     print("Name:".tag(.title)) 
     // returns: "<title>Name:</title>
     
     ````
     - parameter tag: Tag enum to wrap text
     - returns: current text wrapped by tag
     */
    func tag(_ tag: Tag) -> String {
        return tag.wrap(string: self)
    }
    
    /**
     Return width from string based on height and font attributes
     
     - parameter height: height to base the string
     - parameter font: font attributes to check text
     - returns: width total based on attributes
     */
    func contraint(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSFontAttributeName: font],
                                            context: nil)
        return boundingBox.width
    }
    
    /**
     Find the first Int based on Regular Expression
     
     - parameter pattern: regular expression to find an Int
     - returns: first Int found
     */
    func regex(_ pattern: String) -> Int {
        let results: [Int] = self.regex(pattern)
        guard let item = results.first, results.count > 0 else {
            return NSNotFound
        }
        
        return item
    }
    
    /**
     Find a list of Int based on Regular Expression
     
     - parameter pattern: regular expression to find a list of Int
     - returns: list of Int found
     */
    func regex(_ pattern: String) -> [Int] {
        
        if let expression = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
            let results = expression.matches(in: self, options: .reportCompletion, range: NSRange(location: 0, length: self.characters.count))
            
            let contents: [Int] = results.flatMap({
                let value = (self as NSString).substring(with: $0.rangeAt(1))
                return Int(value)
            })
            
            return contents
        }
        
        return []
    }

    
}