//
//  File.swift
//  
//
//  Created by Brett Chapin on 12/3/20.
//

import Foundation

// MARK: Array<Int>
extension Array where Element == Int {
    func product() -> Int {
        var product = self[0]
        
        for i in 1..<self.count {
            product *= self[i]
        }
        
        return product
    }
}
