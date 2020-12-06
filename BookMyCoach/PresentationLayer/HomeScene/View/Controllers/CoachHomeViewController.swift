//
//  CoachHomeViewController.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import UIKit

class CoachHomeViewController: UIViewController {
    
    @IBOutlet weak var currentLocationBarItem: UIBarButtonItem!
    @IBOutlet weak var bookingCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CoachHomeViewModel!
    
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
        
        viewModel.pendingBookings.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        viewModel.bookings.bind { [weak self] _ in
            self?.bookingCollectionView.reloadData()
        }
        
        viewModel.placemark.bind { (placemark) in
            self.currentLocationBarItem.title = placemark
        }
        
        viewModel.showSuccess.bind { isAccepted in
            guard isAccepted != nil else { return }
            if isAccepted == true {
                ToastView.showSuccess(Constant.bookingRequestAccepted)
            } else {
                ToastView.showSuccess(Constant.bookingRequestRejected)
            }
        }
        
    }
    
}

extension CoachHomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalPendingBookings
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cellWithType(PendingBookingTableViewCell.self, indexPath: indexPath)
        cell.fill(with: viewModel.pendingBooking(at: indexPath.item))
        cell.bookingResponseAction = { [weak self] (bookingId, isAccepted) in
            self?.viewModel.bookingResponseAction(bookingId: bookingId, isAccept: isAccepted)
        }
        return cell
    }
    
}

extension CoachHomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.totalBookings
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cellWithType(BookingCollectionViewCell.self, for: indexPath)
        cell.fill(with: viewModel.booking(at: indexPath.item))
        return cell
    }

}

extension CoachHomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 180)
    }
    
}
