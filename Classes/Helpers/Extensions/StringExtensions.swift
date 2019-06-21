//
//  StringExtensions.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation

extension String{
    
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

