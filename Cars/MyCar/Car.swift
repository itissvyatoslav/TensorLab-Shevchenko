//
//  Car.swift
//  AutoCatalog
//
//  Created by Гость on 24/10/2019.
//  Copyright © 2019 sia. All rights reserved.
//

import Foundation

struct Car: CustomStringConvertible, Equatable, Codable {
    private let id: UUID = UUID()
    
    let name: String
    let year: Int
    let model: String
    
    var description: String {
        return """
        Name \(name)
        Year \(year)
        Model \(model)
        """
    }
    
    static func ==(lhs: Car, rhs: Car) -> Bool {
        return lhs.id == rhs.id
    }
}

