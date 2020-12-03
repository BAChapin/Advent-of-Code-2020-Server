//
//  File.swift
//  
//
//  Created by Brett Chapin on 12/3/20.
//

import Foundation
import Vapor

final class Day2Controller: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let input = routes.grouped("2")
        
        input.on(.GET, "part1", body: .collect(maxSize: "1mb"), use: answerForPartOne)
        input.on(.GET, "part2", body: .collect(maxSize: "1mb"), use: answerForPartTwo)
    }
    
    private func getData(from string: String?) throws -> [PasswordEntry] {
        guard let rawText = string else { throw Abort(.badRequest) }
        var list = rawText.components(separatedBy: .newlines)
        list.removeAll(where: { $0 == "" })
        return list.compactMap { PasswordEntry($0) }
    }
    
    func answerForPartOne(_ req: Request) throws -> Int {
        let input = try getData(from: req.body.string)
        var runningTotal = 0
        
        input.forEach { entry in
            runningTotal += entry.isValidForSledRental() ? 1 : 0
        }
        
        return runningTotal
    }
    
    func answerForPartTwo(_ req: Request) throws -> Int {
        let input = try getData(from: req.body.string)
        var runningTotal = 0
        
        input.forEach { entry in
            runningTotal += entry.isValidForTobogganRental() ? 1 : 0
        }
        
        return runningTotal
    }

}
