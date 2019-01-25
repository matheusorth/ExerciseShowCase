//
//  Exercise.swift
//  ExerciseShowCase
//
//  Created by Matheus Orth on 25/01/19.
//  Copyright © 2019 collab. All rights reserved.
//

import Foundation

struct Exercise: Codable {
    let id: Int
    let licenseAuthor, status, description, name: String
    let nameOriginal, creationDate, uuid: String
    let license, category, language: Int
    let musclesIds, musclesSecondaryIds, equipmentIds: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id
        case licenseAuthor = "license_author"
        case status, description, name
        case nameOriginal = "name_original"
        case creationDate = "creation_date"
        case uuid, license, category, language
        case musclesIds = "muscles"
        case musclesSecondaryIds = "muscles_secondary"
        case equipmentIds = "equipment"
    }
}
