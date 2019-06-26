//
//  StringExtensions.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 17/04/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    
    func md5() -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = self.data(using:.utf8)!
        var digestData = Data(count: length)
        
        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    private mutating func addChar(fromString string2: String) {
        
        let firstIndex = self.getRandomIndex()
        let secondIndex = string2.getRandomIndex()
        let auxRange = firstIndex...firstIndex
        self.replaceSubrange(auxRange, with: String(string2[secondIndex]))
    }
    
    private func validate(withString string2: String) -> Bool{
        
        for char in string2{
            if self.contains(char){
                return true
            }
        }
        return false
    }
    
    func getRandomIndex() -> String.Index{
        let randomIndex = Int(arc4random_uniform(UInt32(self.count)))
        
        //        print("self = \(self)")
        //        print("randomIndex = \(randomIndex)")
        
        if randomIndex > 1{
            let resultIndex = self.index(self.startIndex, offsetBy: randomIndex - 1)
            return resultIndex
        } else {
            return self.startIndex
        }
    }
    
    static func generateRandomString(with length: Int = 12, _ useUpperCase: Bool = true, _ useNumeric: Bool = true, _ useSymbols: Bool = false) -> String {
        
        var generatedString = ""
        
        let lowerCase = "abcdefghijklmnopqrstuvwxyz"
        let upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let numeric = "0123456789"
        let symbols = "§±!@#$%ˆ&*()_+-=[]{};':˜`,./<>?"
        
        var charsPool = lowerCase
        
        if useUpperCase {
            charsPool.append(upperCase)
        }
        
        if useNumeric {
            charsPool.append(numeric)
        }
        
        if useSymbols{
            charsPool.append(symbols)
        }
        
        for _ in 0..<length {
            let charIndex = charsPool.getRandomIndex()
            generatedString.append(String(charsPool[charIndex]))
        }
        
        var hasUpper = false
        var hasNumeric = false
        var hasSymbol = false
        
        while(!hasUpper || !hasNumeric || !hasSymbol) {
            
            if !useUpperCase {
                hasUpper = true
            } else {
                hasUpper = generatedString.validate(withString: upperCase)
            }
            
            if !useNumeric {
                hasNumeric = true
            } else {
                hasNumeric = generatedString.validate(withString: numeric)
            }
            
            if !useSymbols {
                hasSymbol = true
            } else {
                hasSymbol = generatedString.validate(withString: symbols)
            }
            
            if !hasUpper {
                generatedString.addChar(fromString: upperCase)
            }
            
            if !hasNumeric {
                generatedString.addChar(fromString: numeric)
            }
            
            if !hasSymbol {
                generatedString.addChar(fromString: symbols)
            }
            
        }
        
        return generatedString
    }
}

