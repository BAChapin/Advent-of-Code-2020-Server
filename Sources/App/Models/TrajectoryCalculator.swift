//
//  File.swift
//  
//
//  Created by Brett Chapin on 12/3/20.
//

import Foundation


typealias Trajectory = (down: Int, right: Int)

struct TrajectoryCalculator {
    
    var map: [MapLayer] = []
    
    init(_ input: [String]) {
        let list = input.filter { $0 != "" }
        self.map = list.compactMap { MapLayer($0) }
    }
    
    func numberOfTrees(with trajectory: Trajectory) -> Int {
        var numberOfTrees = 0
        var numberOfLoops = 1
        
        for num in stride(from: trajectory.down, to: map.count, by: trajectory.down) {
            
            numberOfTrees += map[num].isTree(trajectory.right * numberOfLoops) ? 1 : 0
            numberOfLoops += 1
        }
        
        return numberOfTrees
    }
    
    func numberOfTrees(with trajectories: [Trajectory]) -> Double {
        var numberOfTrees: [Int] = []
        
        for trajectory in trajectories {
            numberOfTrees.append(self.numberOfTrees(with: trajectory))
        }
        
        return numberOfTrees.product()
    }
}
