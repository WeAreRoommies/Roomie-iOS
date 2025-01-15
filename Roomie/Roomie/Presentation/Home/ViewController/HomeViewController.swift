//
//  ViewController.swift
//  Roomie
//
//  Created by 예삐 on 1/7/25.
//

import UIKit
import Combine

import SnapKit
import Then
import CombineCocoa

final class HomeViewController: BaseViewController {
    
    // MARK: - Property
    
    private let viewModel: HomeViewModel
    
    private let cancelBag = CancelBag()
    
    private let rootView = HomeView()
    
    final let cellHeight: CGFloat = 120 //112 + 4 + 4
    
    private var recentlyRooms: [HomeModel] = HomeModel.mockHomeData()
    
    // MARK: - Initializer
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.roomListtableView.delegate = self
        rootView.roomListtableView.dataSource = self
        
        rootView.roomListtableView.register(
            RoomListTableViewCell.self,
            forCellReuseIdentifier: RoomListTableViewCell.reuseIdentifier
        )
        
        updateTableViewHeight()
    }
    
    // MARK: - Functions
    
    override func setAction() {
        rootView.updateButton.updateButton
            .tapPublisher
            .sink {
                // TODO: 화면 전환하기
            }
            .store(in: cancelBag)
        
        rootView.calmCardView.moodButton
            .tapPublisher
            .sink {
                // TODO: 화면 전환하기
            }
            .store(in: cancelBag)
        
        rootView.livelyCardView.moodButton
            .tapPublisher
            .sink {
                // TODO: 화면 전환하기
            }
            .store(in: cancelBag)
        
        rootView.neatCardView.moodButton
            .tapPublisher
            .sink {
                // TODO: 화면 전환하기
            }
            .store(in: cancelBag)
    }
    
    private func updateTableViewHeight() {
        let totalHeight = CGFloat(recentlyRooms.count * 120)
        
        rootView.roomListTableViewHeightConstraint?.update(offset: totalHeight)
        rootView.layoutIfNeeded()
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return cellHeight
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        // TODO: 상세매물 페이지와 연결
    }

}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return recentlyRooms.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RoomListTableViewCell.reuseIdentifier, for: indexPath
        ) as? RoomListTableViewCell else {
            return UITableViewCell()
        }
        
        let data = recentlyRooms[indexPath.row]
        
        cell.dataBind(
            data.mainImageURL,
            houseId: data.houseID,
            montlyRent: data.monthlyRent,
            deposit: data.deposit,
            occupanyTypes: data.occupancyType,
            location: data.location,
            genderPolicy: data.genderPolicy,
            locationDescription: data.locationDescription,
            isPinned: data.isPinned,
            moodTag: data.moodTag,
            contract_term: data.contractTerm
        )
        
        return cell
    }
}
