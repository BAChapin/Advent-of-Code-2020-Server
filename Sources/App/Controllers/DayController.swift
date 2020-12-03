//
//  File.swift
//  
//
//  Created by Brett Chapin on 12/3/20.
//

import Foundation
import Vapor

final class DayController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let day = routes.grouped("day")
        
        try day.register(collection: Day1Controller())
    }
    
}
