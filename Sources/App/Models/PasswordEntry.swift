//
//  File.swift
//  
//
//  Created by Brett Chapin on 12/3/20.
//

import Foundation

struct PasswordEntry {
    let range: ClosedRange<Int>
    let neededLetter: Character
    let password: String
    
    init(_ input: String) {
        let values = input.components(separatedBy: .whitespaces)
        
        self.range = ClosedRange(values[0])
        self.neededLetter = values[1][0]
        self.password = values[2]
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
