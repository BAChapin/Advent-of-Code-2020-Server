//
//  File.swift
//  
//
//  Created by Brett Chapin on 12/3/20.
//

import Foundation
import Vapor

typealias Year = Int

struct Day1Generator: Content {
    static let year: Year = 2020
    
    let part1: YearInTwo
    let part2: YearInThree
    let years: [Year]
    
    struct YearInTwo: Content {
        let firstYear: Year
        let secondYear: Year
        var answer: Year
        
        var array: [Year] {
            return [firstYear, secondYear]
        }
        
        init(first: Year, second: Year) {
            self.firstYear = first
            self.secondYear = second
            self.answer = first * second
        }
        
        static func generate() -> YearInTwo {
            let first = Year.random(in: 200...2000)
            return YearInTwo(first: first, second: 2020 - first)
        }
    }
    
    struct YearInThree: Content {
        let firstYear: Year
        let secondYear: Year
        let thirdYear: Year
        var answer: Year
        
        var array: [Year] {
            return [firstYear, secondYear, thirdYear]
        }
        
        init(first: Year, second: Year, third: Year) {
            self.firstYear = first
            self.secondYear = second
            self.thirdYear = third
            self.answer = first * second * third
        }
        
        static func generate() -> YearInThree {
            let first = Year.random(in: 200...1500)
            let second = Year.random(in: 200...(1500 - first))
            return YearInThree(first: first, second: second, third: 2020 - first - second)
        }
    }
    
    init(numberOf years: Year = 200) {
        self.part1 = YearInTwo.generate()
        self.part2 = YearInThree.generate()
        var tempYears = part1.array
        tempYears.append(contentsOf: part2.array)
        
        for _ in 0..<(years - tempYears.count) {
            var isUsable: Bool = false
            
            while !isUsable {
                let randomYear = Year.random(in: 1...2020)
                
                if !tempYears.checkForYearInTwo(against: randomYear, year: Day1Generator.year) && !tempYears.checkForYearInThree(against: randomYear, year: Day1Generator.year) {
                    tempYears.append(randomYear)
                    isUsable = true
                }
            }
        }
        
        self.years = tempYears.shuffled()
    }
}
