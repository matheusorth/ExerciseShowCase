//
//  ExerciseDetailTableViewController.swift
//  ExerciseShowCase
//
//  Created by Matheus Orth on 25/01/19.
//  Copyright © 2019 collab. All rights reserved.
//

import UIKit

class ExerciseDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var viewModel: ExerciseDetailViewModel! {
        didSet {
            bindViewModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(viewModel != nil, "pseudoInject in segue/present")
        updateHeaderView()
        tableView.tableFooterView = UIView()
    }
    
    private func updateHeaderView() {
        nameLabel.text = viewModel.exercise.name
        categoryLabel.text = viewModel.exercise.category?.name
    }
    
    private func bindViewModel() {
        viewModel.updatedExerciseImages = { [weak self] sectionIndex in
            self?.tableView.reloadSections(IndexSet(integer: sectionIndex), with: .automatic)
        }
    }
  

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section)
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.sections[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: section.cellIdentifier, for: indexPath)
        
        switch section {
        case .description:
            cell.textLabel?.text = viewModel.exercise.description
        case .equipment:
            cell.textLabel?.text = viewModel.exercise.equipments?[indexPath.row].name
        case .muscle:
            cell.textLabel?.text = viewModel.exercise.muscles?[indexPath.row].name
        case .images:
            (cell as? ExerciseDetailImagesTableViewCell)?.imagesUrls = viewModel.imagesURL
        }


        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.numberOfRows(section) == 0
            ? nil
            : viewModel.sections[section].headerTitle
    }

}
