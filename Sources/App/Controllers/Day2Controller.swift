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
        input.get("json", use: json)
        input.get("json", ":num", use: json)
        input.get("raw", use: raw)
        input.get("raw", ":num", use: raw)
    }
    
    private func getData(from string: String?) throws -> [PasswordEntry] {
        guard let rawText = string else { throw Abort(.badRequest) }
        var list = rawText.components(separatedBy: .newlines)
        list.removeAll(where: { $0 == "" })
        return list.compactMap { PasswordEntry($0) }
    }
    
    func json(_ req: Request) throws -> Day2Generator {
        guard let string = req.parameters.get("num") else { return Day2Generator() }
        guard let num = Int(string) else { throw Abort(.badRequest) }
        
        return Day2Generator(num)
    }
    
    func raw(_ req: Request) throws -> String {
        guard let string = req.parameters.get("num") else { return Day2Generator().rawRepresentation() }
        guard let num = Int(string) else { throw Abort(.badRequest) }
        
        return Day2Generator(num).rawRepresentation()
    }
    
    func answerForPartOne(_ req: Request) throws -> Int {
        let input = try getData(from: req.body.string)
        
        return input.correctPasswordsForSled()
    }
    
    func answerForPartTwo(_ req: Request) throws -> Int {
        let input = try getData(from: req.body.string)
        
        return input.correctPasswordsForToboggan()
    }

}
