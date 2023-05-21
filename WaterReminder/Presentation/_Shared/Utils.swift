//
//  Utils.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/05/23.
//

import Foundation


func generateRandomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    var randomString = ""
    
    for _ in 0..<length {
        let randomIndex = Int(arc4random_uniform(UInt32(letters.count)))
        let randomLetter = letters[letters.index(letters.startIndex, offsetBy: randomIndex)]
        randomString += String(randomLetter)
    }
    
    return randomString
}


extension Int {
    
    func toML() -> String {
        return "\(String(self)) ml"
    }

}
