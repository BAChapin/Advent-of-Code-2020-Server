//
//  File.swift
//  
//
//  Created by Brett Chapin on 12/3/20.
//

import Foundation

extension String {
    subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }
    
    mutating func replaceCharacter(at index: Int, with char: Character) {
        var chars = Array(self)
        chars[index] = char
        self = String(chars)
    }
}
