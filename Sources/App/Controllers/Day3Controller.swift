//
//  File.swift
//  
//
//  Created by Brett Chapin on 12/3/20.
//

import Foundation
import Vapor

final class Day3Controller: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let input = routes.grouped("3")
        
        input.get("part1", use: answerForPartOne)
        input.get("part2", use: answerForPartTwo)
        input.get("json", use: json)
        input.get("raw", use: raw)
    }
    
    private func getCalculator(from string: String?) throws -> TrajectoryCalculator {
        guard let rawText = string else { throw Abort(.badRequest) }
        let list = rawText.components(separatedBy: .newlines)
        return TrajectoryCalculator(list)
    }
    
    func json(_ req: Request) throws -> Day3Generator {
        return Day3Generator()
    }
    
    func raw(_ req: Request) throws -> String {
        return Day3Generator().rawRepresentation()
    }
    
    func answerForPartOne(_ req: Request) throws -> Int {
        let calculator = try getCalculator(from: req.body.string)
        
        return calculator.numberOfTrees(with: (1, 3))
    }
    
    func answerForPartTwo(_ req: Request) throws -> Int {
        let calculator = try getCalculator(from: req.body.string)
        
        let trajectories: [Trajectory] = [(1,1),
                                          (1,3),
                                          (1, 5),
                                          (1, 7),
                                          (2, 1)]
        
        return calculator.numberOfTrees(with: trajectories)
    }
}
