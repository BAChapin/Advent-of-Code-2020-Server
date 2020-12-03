//
//  File.swift
//  
//
//  Created by Brett Chapin on 12/3/20.
//

import Foundation

// MARK: Array<Int>
extension Array where Element == Int {
    func product() -> Int {
        var product = self[0]
        
        for i in 1..<self.count {
            product *= self[i]
        }
        
        return product
    }
    
    func checkForYearInTwo(against: Int, year: Int) -> Bool {
        let check = year - against
        return self.contains(check)
    }
    
    func checkForYearInThree(against: Int, year: Int) -> Bool {
        let check = year - against
        
        for num in self {
            let finalCheck = check - num
            
            if self.contains(finalCheck) {
                return true
            }
        }
        
        return false
    }
}

extension Array where Element == PasswordEntry {
    func correctPasswordsForSled() -> Int {
        var runningTotal = 0
        
        self.forEach { entry in
            runningTotal += entry.isValidForSledRental() ? 1 : 0
        }
        
        return runningTotal
    }
    
    func correctPasswordsForToboggan() -> Int {
        var runningTotal = 0
        
        self.forEach { entry in
            runningTotal += entry.isValidForTobogganRental() ? 1 : 0
        }
        
        return runningTotal
    }
}
