//
//  ViewController.swift
//  ExerciseShowCase
//
//  Created by Matheus Orth on 25/01/19.
//  Copyright © 2019 collab. All rights reserved.
//

import UIKit

class ExerciseListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ExerciseListViewModel! {
        didSet {
            bindViewModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ExerciseListViewModel()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        
    }
    
    private func bindViewModel() {
        viewModel.updatedExercises = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? ExerciseTableViewCell,
            let exercise = cell.viewModel?.exercise,
            let exerciseDetailViewController = segue.destination as? ExerciseDetailTableViewController {
            // pseudo viewModel inject, better if Swinject. It fail if not set with assert in ExerciseDetailTableViewController.viewDidLoad
            exerciseDetailViewController.viewModel = ExerciseDetailViewModel(exercise: exercise)
        }
    }

}


// MARK: - UITableView

extension ExerciseListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.exercisesViewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "exercise", for: indexPath) as? ExerciseTableViewCell,
            let exerciseViewModel = viewModel.exercisesViewModel?[indexPath.row] else { return UITableViewCell() }
        cell.viewModel = exerciseViewModel
        return cell
    }

}

extension ExerciseListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135.0
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 10.0 {
            viewModel.loadNextPage()
        }
    }
    
}
