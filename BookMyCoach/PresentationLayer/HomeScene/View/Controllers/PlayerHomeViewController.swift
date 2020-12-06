//
//  PlayerHomeViewController.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import UIKit

class PlayerHomeViewController: UIViewController {

    @IBOutlet weak var placemarkNameItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bookingsCollectionView: UICollectionView!
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    
    var viewModel: PlayerHomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    private func bind() {

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
        
        viewModel.sports.bind { [weak self] _ in
            self?.sportsCollectionView.reloadData()
        }
        
        viewModel.coaches.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        viewModel.bookings.bind { [weak self] _ in
            self?.bookingsCollectionView.reloadData()
        }
        
        viewModel.placemark.bind { (placemark) in
            self.placemarkNameItem.title = placemark
        }
        
        viewModel.showBookingSuccess.bind { success in
            if success == true {
                ToastView.showSuccess(Constant.bookingRequestSent)
            }
        }
        
    }

}

extension PlayerHomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCoaches
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cellWithType(NearbyCoachTableViewCell.self, indexPath: indexPath)
        cell.fill(with: viewModel.coach(at: indexPath.item))
        cell.bookNowAction = { [weak self] coachId in
            self?.viewModel.bookNowAction(coachId: coachId)
        }
        return cell
    }
    
}

extension PlayerHomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == bookingsCollectionView ? viewModel.totalBookings : viewModel.totalSports
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bookingsCollectionView {
            let cell = collectionView.cellWithType(BookingCollectionViewCell.self, for: indexPath)
            cell.fill(with: viewModel.booking(at: indexPath.item))
            return cell
        } else {
            let cell = collectionView.cellWithType(SportCollectionViewCell.self, for: indexPath)
            let sport = viewModel.sport(at: indexPath.item)
            cell.fill(with: sport.name, icon: sport.icon)
            return cell
        }
    }

}

extension PlayerHomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bookingsCollectionView {
            return CGSize(width: UIScreen.main.bounds.width, height: 180)
        } else {
            return CGSize(width: 128, height: 100)
        }
    }
    
}
