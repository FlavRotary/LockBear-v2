//
//  KeychainManager.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import KeychainSwift

class KeychainAndEncryption{
    static func createAndStore(){
        do {
            let password: String = String.generateRandomString(with: 3, true, true, true)
            let dataFromPass = password.data(using: .utf8)
            let salt = AES256Crypter.randomSalt()
            let key = try AES256Crypter.createKey(password: dataFromPass!, salt: salt)
            let keychain = KeychainSwift()
            keychain.set(key, forKey: "AESKey", withAccess: KeychainSwiftAccessOptions.accessibleWhenUnlockedThisDeviceOnly)
        } catch {
            print("Failed To Create Key. Check for Errors!\n")
            print(error)
        }
    }
    
    static func ecryptWithAES(_ sourceString:String) -> (Data?,Data?){
        do{
            let keychain = KeychainSwift()
            let key = keychain.getData("AESKey")
            let dataToEncrypt = sourceString.data(using: .utf8)
            let iv = AES256Crypter.randomIv()
            let aes = try AES256Crypter(key: key!, iv: iv)
            let encryptedData = try aes.encrypt(dataToEncrypt!)
            return (encryptedData,iv)
            
        } catch {
            print("Failed the operation of Encryption. Check for errors! \n")
            print(error)
            return (nil,nil)
        }
    }
    
    static func decryptforAES(_ givenData: Data, _ givenIv: Data) -> String?{
        do{
            let keychain = KeychainSwift()
            let key = keychain.getData("AESKey")
            let aes = try AES256Crypter(key: key!, iv: givenIv)
            let decryptedData = try aes.decrypt(givenData)
            let resultedString = String(data: decryptedData, encoding: String.Encoding.utf8)
            return resultedString!
        } catch {
            print("Failed the operation of Decryption. Check for Errors!\n")
            return nil
        }
    }
}
