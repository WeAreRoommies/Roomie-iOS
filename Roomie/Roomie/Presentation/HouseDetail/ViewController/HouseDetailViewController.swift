//
//  HouseDetailViewController.swift
//  Roomie
//
//  Created by 김승원 on 1/16/25.
//

import UIKit
import Combine

import CombineCocoa

final class HouseDetailViewController: BaseViewController {
    
    // MARK: - Property
    
    private let rootView = HouseDetailView()
    
    private let roomStatusCellHeight: CGFloat = Screen.height(182 + 12)
    private let roomStatusCellCount = 2 // TODO: DataBind
    
    private let roommateCellHeight: CGFloat = Screen.height(102 + 12)
    private let roommateCellCount = 3 // TODO: DataBind
    
    private let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    
    private let cancelBag = CancelBag()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print("HouseDetailViewController: ViewDidLoad()")
        setRegister()
        
        rootView.safetyLivingFacilityView.dataBind(["침대", "침구", "옷장", "냉장고", "세탁기", "믹서", "드라이기"])
        rootView.kitchenFacilityView.dataBind(["냉장고", "세탁기", "믹서", "드라이기"])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewWillAppearSubject.send(())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        rootView.updateRoomStatusTableViewHeight(roomStatusCellCount, height: roomStatusCellHeight)
        rootView.roomStatusTableView.layoutIfNeeded()
        
        rootView.updateRoommateTableViewHeight(roommateCellCount, height: roommateCellHeight)
        
    }
    
    override func setDelegate() {
        rootView.roomStatusTableView.dataSource = self
        rootView.roomStatusTableView.delegate = self
        
        rootView.roommateTableView.dataSource = self
        rootView.roommateTableView.delegate = self
    }
}

// MARK: - Functions

private extension HouseDetailViewController {
    func setRegister() {
        rootView.roomStatusTableView.register(
            RoomStatusTableViewCell.self,
            forCellReuseIdentifier: RoomStatusTableViewCell.reuseIdentifier
        )
        
        rootView.roommateTableView.register(
            RoommateTableViewCell.self,
            forCellReuseIdentifier: RoommateTableViewCell.reuseIdentifier
        )
        
        rootView.roommateTableView.register(
            RoommateNotFoundTableViewCell.self,
            forCellReuseIdentifier: RoommateNotFoundTableViewCell.reuseIdentifier
        )
    }
}

// MARK: - UITableViewDataSource

extension HouseDetailViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        if tableView == rootView.roomStatusTableView {
            return roomStatusCellCount // TODO: DataBind
        }
        
        if tableView == rootView.roommateTableView {
            let cellCount = roommateCellCount == 0 ? 1 : roommateCellCount
            return cellCount // TODO: DataBind
        }
        
        return 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        if tableView == rootView.roomStatusTableView {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RoomStatusTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? RoomStatusTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            
            // TODO: DataBind
            return cell
        }
        
        if tableView == rootView.roommateTableView {
            if roommateCellCount == 0 {
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: RoommateNotFoundTableViewCell.reuseIdentifier,
                    for: indexPath
                ) as? RoommateNotFoundTableViewCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                print("기본 셀 출력")
                // TODO: DataBind
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: RoommateTableViewCell.reuseIdentifier,
                    for: indexPath
                ) as? RoommateTableViewCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                
                // TODO: DataBind
                return cell
            }
        }

        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension HouseDetailViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        if tableView == rootView.roomStatusTableView {
            return roomStatusCellHeight
        }
        
        if tableView == rootView.roommateTableView {
            return roommateCellHeight
        }
        
        return 0
    }
}
