//
//  NetworkModel.swift
//  ExerciseShowCase
//
//  Created by Matheus Orth on 25/01/19.
//  Copyright © 2019 collab. All rights reserved.
//

import Foundation

struct NetworkResult<T: Codable>: Codable {
    let count: Int?
    let next, previous: String?
    let results: [T]?
}
