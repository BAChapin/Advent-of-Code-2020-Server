//
//  File.swift
//  
//
//  Created by Brett Chapin on 12/3/20.
//

import Foundation
import Vapor

struct Day3Generator: Content, RawRepresentable {
    
    var answers: Answers
    var map: [String]
    
    struct Answers: Content {
        static let testTrajectories: [Trajectory] = [(1,1),
                                              (1,3),
                                              (1, 5),
                                              (1, 7),
                                              (2, 1)]
        var part1: Int
        var part2: Int
        
        init(calculator: TrajectoryCalculator) {
            self.part1 = calculator.numberOfTrees(with: (1, 3))
            self.part2 = calculator.numberOfTrees(with: Answers.testTrajectories)
        }
    }
    
    init(numberOf layers: Int = 323) {
        var mapLayers: [String] = []
        
        for _ in 0..<layers {
            mapLayers.append(MapLayer.generate().description)
        }
        
        self.map = mapLayers
        self.answers = Answers(calculator: TrajectoryCalculator(mapLayers))
    }
    
    func rawRepresentation() -> String {
        return map.joined(separator: "\n")
    }
}
