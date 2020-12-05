//
//  File.swift
//  
//
//  Created by Brett Chapin on 12/3/20.
//

import Foundation
import Vapor

final class Day1Controller: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let input = routes.grouped("1")
        
        input.get("part1", use: answerForPartOne)
        input.get("part2", use: answerForPartTwo)
        input.get("json", use: json)
        input.get("json", ":num", use: json)
        input.get("raw", use: raw)
        input.get("raw", ":num", use: raw)
    }
    
    func json(_ req: Request) throws -> Day1Generator {
        guard let string = req.parameters.get("num") else { return Day1Generator() }
        guard let num = Int(string) else { throw Abort(.badRequest) }
        
        if num < 6 {
            throw Abort(.expectationFailed)
        }
        
        return Day1Generator(numberOf: num)
    }
    
    func raw(_ req: Request) throws -> String {
        guard let string = req.parameters.get("num") else { return Day1Generator().rawRepresentation() }
        guard let num = Int(string) else { throw Abort(.badRequest) }
        
        if num < 6 {
            throw Abort(.expectationFailed)
        }
        
        return Day1Generator(numberOf: num).rawRepresentation()
    }
    
    func answerForPartOne(_ req: Request) throws -> Int {
        guard let rawText = req.body.string else { throw Abort(.badRequest) }
        let input = rawText.components(separatedBy: .newlines).compactMap { Int($0) }.sorted()
        
        for i in 0..<input.count {
            let first = input[i]
            let remainder = 2020 - first
            
            if let x = input.firstIndex(of: remainder) {
                let second = input[x]
                let product = first * second
                print("\(first) + \(second) = 2020, product = \(product)")
                return product
            }
        }
        
        throw Abort(.notFound)
    }
    
    func answerForPartTwo(_ req: Request) throws -> Int {
        guard let rawText = req.body.string else { throw Abort(.badRequest) }
        let input = rawText.components(separatedBy: .newlines).compactMap { Int($0) }.sorted()
        
        for i in 0..<input.count {
            let first = input[i]
            for y in (i+1)..<input.count {
                let second = input[y]
                let sum = first + second
                let remainder = 2020 - sum
                
                if let x = input.firstIndex(of: remainder) {
                    let third = input[x]
                    let product = first * second * third
                    return product
                }
            }
        }
        
        throw Abort(.notFound)
    }
    
    
}
