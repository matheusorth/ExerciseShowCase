//
//  ExerciseTableViewCell.swift
//
//  Created by Matheus Orth on 23/01/19.
//  Copyright © 2019 collab. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var downArrowImageView: UIImageView!
    @IBOutlet weak var musclesLabel: UILabel!
    @IBOutlet weak var equipmentsLabel: UILabel!
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bottomViewConstraint.constant = -1.0
    }

    func configure(with exercise: ExerciseListViewModel.ExerciseSimplefied) {
        nameLabel.text = exercise.name
        categoryLabel.text = exercise.category?.name
        
        let muscles = exercise.muscles?.map({ $0.name }).joined(separator: ", ")
        musclesLabel.text = muscles != nil
            ? String(format: NSLocalizedString("Muscles: %@", comment: ""), muscles!)
            : nil
        
        let equipments = exercise.equipments?.map({ $0.name }).joined(separator: ", ")
        equipmentsLabel.text = equipments != nil
            ? String(format: NSLocalizedString("Equipments: %.f", comment: ""), equipments!)
            : nil
        
//        guard let imagePath = exercise.imagePath, let imageURL = URL(string: imagePath) else { return }
//        DispatchQueue.main.async {
//            let image = SVGKImage(contentsOf: imageURL)
//            self.exerciseImageView?.image = image?.uiImage
//        }
    }
}
