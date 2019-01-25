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
    var viewModel: ExerciseListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ExerciseListViewModel()
    }

}


// MARK: - UITableView

extension ExerciseListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.exercises?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "exercise", for: indexPath) as? ExerciseTableViewCell,
        let exercise = viewModel.exercises?[indexPath.row] else { return UITableViewCell() }
        cell.configure(with: exercise)
    
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
    
}
