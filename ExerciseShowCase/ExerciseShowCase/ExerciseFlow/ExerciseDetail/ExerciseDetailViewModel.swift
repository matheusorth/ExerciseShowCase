//
//  ExerciseDetailViewModel.swift
//  ExerciseShowCase
//
//  Created by Matheus Orth on 25/01/19.
//  Copyright © 2019 collab. All rights reserved.
//

import Foundation

class ExerciseDetailViewModel {
    
    var updatedExerciseImages: ((_ sectionIndex: Int)->())? {
        didSet {
            retrieveExerciseImages()
        }
    }
    
    var sections: [Section] {
        return [.description, .images, .equipment, .muscle]
    }
    
    enum Section: Int {
        case description, images, equipment, muscle
    }
    
    let exercise: ExerciseListViewModel.ExerciseSimplefied!
    
    private(set) var imagesURL: [URL]? {
        didSet {
            updatedExerciseImages?(Section.images.rawValue)
        }
    }
    
    // MARK: - Init
    
    init(exercise: ExerciseListViewModel.ExerciseSimplefied) {
        self.exercise = exercise
    }
    
    private func retrieveExerciseImages() {
        Network.retrieveExerciseImage(of: exercise.id, resultBlock: { [weak self] (result) in
            guard let `self` = self else { return }
            self.imagesURL = result.results?.compactMap({ URL(string: $0.image) })
        }) { (error) in
            print(error?.localizedDescription)
        }
    }
    
    func numberOfRows(_ sectionIndex: Int) -> Int {
        let section = sections[sectionIndex]
        switch section {
        case .images:
            return imagesURL == nil || imagesURL?.count ?? 0 == 0 ? 0 : 1
        case .description:
            return exercise.description?.isEmpty ?? false ? 0 : 1
        case .equipment:
            return exercise.equipments?.count ?? 0
        case .muscle:
            return exercise.muscles?.count ?? 0
        }
    }
        
}


extension ExerciseDetailViewModel.Section {
    
    var headerTitle: String {
        switch self {
        case .description:
            return NSLocalizedString("Description", comment: "")
        case .images:
            return NSLocalizedString("Exercise Images", comment: "")
        case .equipment:
            return NSLocalizedString("Equipment", comment: "")
        case .muscle:
            return NSLocalizedString("Muscle", comment: "")
        }
    }
    
    var cellIdentifier: String {
        switch self {
        case .description, .equipment, .muscle:
            return "simpleCell"
        case .images:
            return "exerciseImages"
        }
    }

}
