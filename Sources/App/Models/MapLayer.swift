//
//  File.swift
//  
//
//  Created by Brett Chapin on 12/3/20.
//

import Foundation

struct MapLayer {
    var openSpace: [Int] = []
    var treeSpace: [Int] = []
    
    init(_ input: String) {
        for i in 0..<input.count {
            if input[i] == "." {
                openSpace.append(i)
            } else if input[i] == "#" {
                treeSpace.append(i)
            }
        }
    }
    
    func isTree(_ position: Int) -> Bool {
        let posCheck = Int(position % 31)
        
        return treeSpace.contains(posCheck)
    }
}
