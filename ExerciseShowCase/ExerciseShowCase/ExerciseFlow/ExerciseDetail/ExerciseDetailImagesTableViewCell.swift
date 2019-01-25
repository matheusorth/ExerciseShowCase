//
//  ExerciseDetailImagesTableViewCell.swift
//  ExerciseShowCase
//
//  Created by Matheus Orth on 25/01/19.
//  Copyright © 2019 collab. All rights reserved.
//

import UIKit

class ExerciseDetailImagesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imagesUrls: [URL]? {
        didSet {
            collectionView.dataSource = self
            guard imagesUrls != nil else { return }
            collectionView.reloadData()
        }
    }
}

extension ExerciseDetailImagesTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exerciseDetailImage", for: indexPath) as? ExerciseDetailImageCollectionViewCell,
            let imageURL = imagesUrls?[indexPath.item] else { return UICollectionViewCell() }
        cell.exerciseImageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "exercisePlaceholder"))
        return cell
    }
    
}
