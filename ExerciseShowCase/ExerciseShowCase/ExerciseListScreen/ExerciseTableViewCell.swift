//
//  ExerciseTableViewCell.swift
//
//  Created by Matheus Orth on 23/01/19.
//  Copyright © 2019 collab. All rights reserved.
//

import UIKit
import Kingfisher

class ExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var musclesLabel: UILabel!
    @IBOutlet weak var equipmentsLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
        exerciseImageView.image = UIImage(named: "exercisePlaceholder")
    }
    
    var viewModel: ExerciseTableViewCellViewModel? {
        didSet {
            guard oldValue == nil else { return }
            guard let viewModel = viewModel else { return }
            configure(with: viewModel.exercise)
        }
    }
    
    private func configure(with exercise: ExerciseListViewModel.ExerciseSimplefied) {
        nameLabel.text = exercise.name
        categoryLabel.text = exercise.category?.name
        
        let muscles = exercise.muscles?.map({ $0.name }).joined(separator: ", ")
        musclesLabel.text = muscles != nil && (muscles?.count ?? 0) > 0
            ? String(format: NSLocalizedString("Muscles: %@", comment: ""), muscles!)
            : nil
        
        let equipments = exercise.equipments?.map({ $0.name }).joined(separator: ", ")
        equipmentsLabel.text = equipments != nil && (equipments?.count ?? 0) > 0
            ? String(format: NSLocalizedString("Equipments: %@", comment: ""), equipments!)
            : nil
        
        viewModel?.retrieveImagePath({ [weak self] (imageURL) in
            guard let `self` = self else { return }
            self.exerciseImageView?.kf.setImage(with: imageURL, placeholder: UIImage(named: "exercisePlaceholder"))
        })
    }
    
}

class ExerciseTableViewCellViewModel {
    
    let exercise: ExerciseListViewModel.ExerciseSimplefied!
    
    init(exercise: ExerciseListViewModel.ExerciseSimplefied) {
        self.exercise = exercise
    }
    
    // I didnt bind here just to show other way to update ui. By contraining ui to be update from a method itself.
     func retrieveImagePath(_ updated: @escaping ((URL)->())) {
        Network.retrieveExerciseImage(of: exercise.id, resultBlock: { [weak self] (result) in
            guard let `self` = self else { return }
            guard let imagePath = result.results?.first?.image,
                let imageURL = URL(string: imagePath) else { return }
            updated(imageURL)
        }) { (error) in
            print(error?.localizedDescription)
        }
    }
}
