//
//  File.swift
//  
//
//  Created by Brett Chapin on 12/3/20.
//

import Foundation

struct PasswordEntry: CustomStringConvertible {
    static let characterLimit: Int = 20
    static let characters = "abcdefghijklmnopqrstuvwxyz"
    let range: ClosedRange<Int>
    let neededLetter: Character
    let password: String
    
    var description: String {
        return "\(range.lowerBound)-\(range.upperBound) \(neededLetter): \(password)"
    }
    
    init(_ input: String) {
        let values = input.components(separatedBy: .whitespaces)
        
        self.range = ClosedRange(values[0])
        self.neededLetter = values[1][0]
        self.password = values[2]
    }
    
    init(range: ClosedRange<Int>, neededLetter: Character, password: String) {
        self.range = range
        self.neededLetter = neededLetter
        self.password = password
    }
    
    static func generate(_ repeating: Bool = false) -> PasswordEntry {
        let lower = Int.random(in: 1..<characterLimit)
        let upper = Int.random(in: lower+1...characterLimit) 
        let charCount = Int.random(in: upper...characterLimit)
        let range = lower...upper
        let neededLetter = characters.randomElement()!
        var password: String = ""
        
        let tobogganCheck = Bool.random()
        
        if repeating && tobogganCheck {
            password = generateSledPassword(for: range, with: neededLetter, length: charCount)
        } else if repeating {
            password = generateTobogganPassword(for: range, with: neededLetter, length: charCount)
        } else {
            for _ in 0..<charCount {
                password.append(characters.randomElement()!)
            }
        }
        
        return PasswordEntry(range: range, neededLetter: neededLetter, password: password)
    }
    
    static func generateSledPassword(for range: ClosedRange<Int>, with char: Character, length: Int) -> String {
        var password = ""
        
        for num in 0..<length {
            if range.contains(num) {
                password.append(char)
            } else {
                password.append(characters.randomElement()!)
            }
        }
        
        return password
    }
    
    static func generateTobogganPassword(for range: ClosedRange<Int>, with char: Character, length: Int) -> String {
        var password = ""
        let both = Bool.random()
        let isUpper = Bool.random()
        
        for num in 0..<length {
            if both {
                password.append((num == range.upperBound || num == range.lowerBound) ? char : characters.randomElement()!)
            } else {
                if num == range.upperBound && isUpper {
                    password.append(char)
                } else if num == range.lowerBound && !isUpper {
                    password.append(char)
                } else {
                    password.append(characters.randomElement()!)
                }
            }
        }
        
        return password
    }
    
    private func numberOfNeededLetter() -> Int {
        let sortedPassword = password.sorted()
        return sortedPassword.filter { $0 == neededLetter }.count
    }
    
    func isValidForSledRental() -> Bool {
        let num = numberOfNeededLetter()
        return range.contains(num)
    }
    
    private var positions: (first: Int, second: Int) {
        return (range.lowerBound - 1, range.upperBound - 1)
    }
    
    private var doesFirstInstanceContainLetter: Bool {
        return password[positions.first] == neededLetter && password[positions.second] != neededLetter
    }
    
    private var doesSecondInstanceContainLetter: Bool {
        return password[positions.first] != neededLetter && password[positions.second] == neededLetter
    }
    
    func isValidForTobogganRental() -> Bool {
        return doesFirstInstanceContainLetter || doesSecondInstanceContainLetter
    }
}
