//
//  SportListViewController.swift
//  BookMyCoach
//
//  Created by Bharat Lal on 05/12/20.
//

import UIKit

class SportListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: AppButton!
    
    var viewModel: SportListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        
        viewModel.viewTitle.bind { [weak self] (title) in
            self?.navigationItem.title = title
        }

        viewModel.selectedSport.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        viewModel.refreshData.bind { [weak self] (sports) in
            self?.tableView.reloadData()
        }
        
        // Bind Error
        viewModel.error.bind({ (error) in
            ToastView.showError(error)
        })
        
        // Bind loader
        viewModel.showLoader.bind({ (loader) in
            if loader == true {
                LoaderView.show()
            } else {
                LoaderView.hide()
            }
        })
        
        viewModel.sportUpdatedSuccess.bind { [weak self] (success) in
            if success == true {
                if self?.viewModel.viewMode == ViewMode.normal {
                    AppDICoordinator.setRootControllerForLoggedInUser()
                } else {
                    ToastView.showSuccess(Constant.sportUpdateSuccess)
                    self?.popController()
                }
            }
        }
        
    }
    
    @IBAction func updateSportPressed(_ sender: Any) {
        viewModel.updateSport()
    }
    
}

extension SportListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cellWithType(SportListCell.self, indexPath: indexPath)
        cell.fill(with: viewModel.cellViewModel(at: indexPath.item))
        return cell
    }
    
}

extension SportListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sports.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.sportDidSelect(sport: viewModel.sports[indexPath.item])
    }
    
}
