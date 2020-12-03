//
//  File.swift
//  
//
//  Created by Brett Chapin on 12/3/20.
//

import Foundation

extension ClosedRange where Bound == Int {
    init(_ string: String) {
        let input = string.components(separatedBy: "-").compactMap { Int($0) }
        self = input[0]...input[1]
    }
}
