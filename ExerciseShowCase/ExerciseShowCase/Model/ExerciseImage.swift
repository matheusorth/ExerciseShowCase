//
//  ExerciseImage.swift
//  ExerciseShowCase
//
//  Created by Matheus Orth on 25/01/19.
//  Copyright © 2019 collab. All rights reserved.
//

import Foundation

struct ExerciseImage: Codable {
    let id: Int
    let licenseAuthor, status: String
    let image: String
    let isMain: Bool
    let license, exercise: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case licenseAuthor = "license_author"
        case status, image
        case isMain = "is_main"
        case license, exercise
    }
}
