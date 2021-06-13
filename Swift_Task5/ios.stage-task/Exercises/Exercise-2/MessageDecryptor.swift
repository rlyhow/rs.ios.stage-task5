import UIKit

class MessageDecryptor: NSObject {
    
    let regex = "([0-9]+)?\\[[a-z]+\\]"
    let regex2 = "[0-9]+"
    let regex3 = "[a-z]+"
    let regex4 = "^[a-z]+$"
    
    func decryptMessage(_ message: String) -> String {
        if message.count < 1 || message.count > 60 { return "" }
        let correctSymbols: Set<Character> = ["0","1","2","3","4","5","6","7","8","9",
                                    "a","b","c","d","e","f","g","h","i","j","k",
                                    "l","m","n","o","p","q","r","s","t","u","v",
                                    "w","x","y","z","[","]"]
        var countOfBrackets = 0
        for i in message {
            if !correctSymbols.contains(i) { return "" }
            if i == "[" {
                countOfBrackets+=1
            } else if i == "]" {
                countOfBrackets-=1
            }
            if countOfBrackets < 0 { return "" }
        }
        if countOfBrackets != 0 { return "" }
        
        var mes = message
        var result = matchString(for: regex, in: mes)
        while true {
            if result.isEmpty {
                mes = matchString(for: regex4, in: mes)
                break
            } else {
                let countOfRepeat = Int(matchNumber(for: regex2, in: result))!
                if countOfRepeat < 1 || countOfRepeat > 300 { return "" }
                let stringInBrackets = matchString(for: regex3, in: result)
                var newRepeatedString = ""
                for _ in 0 ..< countOfRepeat {
                    newRepeatedString+=stringInBrackets
                }
                mes = mes.replacingOccurrences(of: result, with: newRepeatedString)
            }
            result = matchString(for: regex, in: mes)
        }
        return mes
    }
    
    func matchString(for regex: String, in text: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let result = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text))
            
            return result.map {String(text[Range($0.range, in: text)!])} ?? ""
            
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return ""
        }
    }
    
    func matchNumber(for regex: String, in text: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let result = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text))
            
            return result.map {String(text[Range($0.range, in: text)!])} ?? "1"
            
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return "0"
        }
    }
    
}
