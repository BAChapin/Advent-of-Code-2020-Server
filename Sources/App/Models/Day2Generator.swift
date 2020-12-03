//
//  File.swift
//  
//
//  Created by Brett Chapin on 12/3/20.
//

import Foundation
import Vapor

struct Day2Generator: Content, RawRepresentable {
    
    var answers: Answers
    var passwords: [String]
    
    struct Answers: Content {
        var part1: Int
        var part2: Int
        
        init(_ passwords: [PasswordEntry]) {
            self.part1 = passwords.correctPasswordsForSled()
            self.part2 = passwords.correctPasswordsForToboggan()
        }
    }
    
    init(_ passwords: Int = 1000) {
        var tempPasswords: [PasswordEntry] = []
        
        for _ in 0..<passwords {
            tempPasswords.append(PasswordEntry.generate(Bool.random()))
        }
        
        self.answers = Answers(tempPasswords)
        self.passwords = tempPasswords.compactMap { $0.description }
    }
    
    func rawRepresentation() -> String {
        return passwords.joined(separator: "\n")
    }
}
