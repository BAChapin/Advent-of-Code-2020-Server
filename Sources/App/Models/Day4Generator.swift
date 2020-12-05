//
//  File.swift
//  
//
//  Created by Brett Chapin on 12/4/20.
//

import Foundation
import Vapor

struct Day4Generator: Content, RawRepresentable {
    
    var answers: Answer
    var passports: [String]
    
    struct Answer: Content {
        let part1: Int
        let part2: Int
    }
    
    init(numberOf passports: Int = 285) {
        var tempArray: [Passport] = []
        
        for _ in 0..<285 {
            let randomEngine = Bool.random()
            
            tempArray.append(Passport.generatePassport(randomEngine))
            print(tempArray.count)
        }
        
        self.passports = tempArray.map { $0.rawRepresentation() }
        print(self.passports.last!)
        self.answers = Answer(part1: tempArray.filter({ $0.isValid() }).count, part2: tempArray.filter({ $0.isDeepScanValid() }).count)
    }
    
    func rawRepresentation() -> String {
        return passports.joined(separator: "\n\n")
    }
}
