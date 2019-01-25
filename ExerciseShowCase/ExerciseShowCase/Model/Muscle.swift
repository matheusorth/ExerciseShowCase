//
//  Muscle.swift
//  ExerciseShowCase
//
//  Created by Matheus Orth on 25/01/19.
//  Copyright © 2019 collab. All rights reserved.
//

import Foundation

struct Muscle: Codable {
    let id: Int
    let name: String
    let isFront: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case isFront = "is_front"
    }
}
