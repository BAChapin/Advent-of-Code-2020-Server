//
//  File.swift
//  
//
//  Created by Brett Chapin on 12/4/20.
//

import Foundation
import Vapor

final class Day4Controller: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let input = routes.grouped("4")
        
        input.on(.GET, "part1", body: .collect(maxSize: "1mb"), use: answerForPartOne)
        input.on(.GET, "part2", body: .collect(maxSize: "1mb"), use: answerForPartTwo)
        input.get("json", use: json)
        input.get("raw", use: raw)
    }
    
    private func getData(from string: String?) throws -> [Passport] {
        guard let rawText = string else { throw Abort(.badRequest) }
        let list = rawText.lines
        let input = Passport.generatePassportArray(from: list)
        return input.map { Passport($0) }
    }
    
    func json(_ req: Request) throws -> Day4Generator {
        return Day4Generator()
    }
    
    func raw(_ req: Request) throws -> String {
        return Day4Generator().rawRepresentation()
    }
    
    func answerForPartOne(_ req: Request) throws -> Int {
        let input = try getData(from: req.body.string)
        print(input.count)
        
        return input.filter( { $0.isValid() }).count
    }
    
    func answerForPartTwo(_ req: Request) throws -> Int {
        let input = try getData(from: req.body.string)
        
        return input.filter( { $0.isDeepScanValid() }).count
    }
}
