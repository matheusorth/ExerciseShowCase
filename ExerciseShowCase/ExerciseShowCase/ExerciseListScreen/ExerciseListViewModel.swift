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
        var id: Int
        var category: ExerciseCategory?
        var muscles, musclesSecondary: [Muscle]?
        var equipments: [Equipment]?
        
        init(id: Int, name: String) {
            self.id = id
            self.name = name
        }
    }
    
    // MARK: - Bindables
    
    var updatedExercises: (() -> ())?
    
    // MARK: - Reactive variables
    
    private(set) var exercisesViewModel: [ExerciseTableViewCellViewModel]? {
        didSet {
            updatedExercises?()
        }
    }
    
    private var resultExercises: NetworkResult<Exercise>? {
        didSet {
            mapExercisesWithDetails()
        }
    }
    
    private var muscles: [Muscle]? {
        didSet {
            mapExercisesWithDetails()
        }
    }
    
    private var equipments: [Equipment]? {
        didSet {
            mapExercisesWithDetails()
        }
    }
    
    private var categories: [ExerciseCategory]? {
        didSet {
            mapExercisesWithDetails()
        }
    }
    
    // MARK: - Init
    
    init() {
        retrieveMuscles()
        retrieveCategory()
        retrieveEquipment()
        retrieveListOfExercise()
    }
    
    // MARK: - Methods
    
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
    
    private func retrieveListOfExercise(_ pageURL: String? = nil) {
        Network.retrieveExercises(pageURL, resultBlock: { (result) in
            self.resultExercises = result
        }) { (error) in
            print(error?.localizedDescription)
        }
    }
    
    private func mapExercisesWithDetails() {
        guard let muscles = muscles else { return }
        guard let categories = categories else { return }
        guard let equipments = equipments else { return }
        guard let exercises = resultExercises?.results else { return }
        let newExercisesViewModels: [ExerciseTableViewCellViewModel] = exercises.map({ exercise in
            var newExercise = ExerciseSimplefied(id: exercise.id, name: exercise.name)
            newExercise.category = categories.filter({ $0.id == exercise.category }).first
            newExercise.equipments = equipments.filter({ exercise.equipmentIds.contains($0.id) })
            newExercise.muscles = muscles.filter({ exercise.musclesIds.contains($0.id) })
            newExercise.musclesSecondary = muscles.filter({ exercise.musclesSecondaryIds.contains($0.id) })
            return ExerciseTableViewCellViewModel(exercise: newExercise)
        })
        
        if self.exercisesViewModel?.append(contentsOf: newExercisesViewModels) == nil {
            self.exercisesViewModel = newExercisesViewModels
        }
    }
    
    // MARK: - Open Method
    
    internal func loadNextPage() {
        guard let nextPageURL = resultExercises?.next else { return }
        retrieveListOfExercise(nextPageURL)
    }
    
}
