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
    private var resultExercises: NetworkResult<Exercise>?
    private var muscles: [Muscle]?
    private var equipments: [Equipment]?
    private var categories: [ExerciseCategory]?
    
    private func retrieveMuscles() {
        Network.retrieveMuscles(resultBlock: { (result) in
            self.muscles = result.results
        }) { (error) in
            print(error?.localizedDescription)
        }
    }
    
    private func retrieveEquipment() {
        Network.retrieveEquipament(resultBlock: { (result) in
            self.equipments = result.results
        }) { (error) in
            print(error?.localizedDescription)
        }
    }
    
    private func retrieveCategory() {
        Network.retrieveCategories(resultBlock: { (result) in
            self.categories = result.results
        }) { (error) in
            print(error?.localizedDescription)
        }
    }
    
    func retrieveListOfExercise() {
        Network.retrieveExercises(nil, resultBlock: { (result) in
            self.resultExercises = result
        }) { (error) in
            print(error?.localizedDescription)
        }
    }
    
}
