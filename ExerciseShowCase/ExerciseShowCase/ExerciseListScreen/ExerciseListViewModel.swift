//
//  ExerciseListViewModel.swift
//  ExerciseShowCase
//
//  Created by Matheus Orth on 25/01/19.
//  Copyright © 2019 collab. All rights reserved.
//

import Foundation

class ExerciseListViewModel {
    
    struct ExerciseSimplefied {
        var name: String
        var imagePath: String?
        var category: ExerciseCategory?
        var muscles, musclesSecondary: [Muscle]?
        var equipments: [Equipment]?
    }
    
    private(set) var exercises: [ExerciseSimplefied]?
    private var muscles: [Muscle]?
    private var equipments: [Equipment]?
    private var categories: [Category]?
    
    private func retrieveMuscles() {
        Network.retrieveMuscles()
    }
    
    private func retrieveEquipment() {
        Network.retrieveEquipament()
    }
    
    private func retrieveCategory() {
        Network.retrieveCategories()
    }
    
    func retrieveListOfExercise() {
        Network.retrieveExercises()
    }
    
}
