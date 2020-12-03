//
//  File.swift
//  
//
//  Created by Brett Chapin on 12/3/20.
//

import Foundation

struct MapLayer: CustomStringConvertible {
    var treeSpace: [Int] = []
    
    var description: String {
        var output = String(repeating: ".", count: 31)
        for location in treeSpace {
            output.replaceCharacter(at: location, with: "#")
        }
        return output
    }
    
    init(_ input: String) {
        for i in 0..<input.count {
            if input[i] == "#" {
                treeSpace.append(i)
            }
        }
    }
    
    init(locations: [Int]) {
        self.treeSpace = locations
    }
    
    static func generate() -> MapLayer {
        return MapLayer(locations: treeLocations())
    }
    
    func isTree(_ position: Int) -> Bool {
        let posCheck = Int(position % 31)
        
        return treeSpace.contains(posCheck)
    }
    
    static func treeLocations() -> [Int] {
        let numOfLocations = Int.random(in: 4...15)
        var locations: [Int] = []
        
        for _ in 0..<numOfLocations {
            var added = false
            
            while !added {
                let randomNum = Int.random(in: 0...30)
                
                if !locations.contains(randomNum) {
                    added = true
                    locations.append(randomNum)
                }
            }
        }
        
        return locations
    }
}
