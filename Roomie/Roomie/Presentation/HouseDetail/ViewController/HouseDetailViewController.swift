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
    
    private let roomStatusCellHeight: CGFloat = 182 + 12
    private let roomStatusCellCount = 2 // TODO: DataBind
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewWillAppearSubject.send(())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        rootView.updateRoomStatusTableViewHeight(roomStatusCellCount, height: roomStatusCellHeight)
        rootView.roomStatusTableView.layoutIfNeeded()
        
    }
    
    override func setDelegate() {
        rootView.roomStatusTableView.dataSource = self
        rootView.roomStatusTableView.delegate = self
    }
}

// MARK: - Functions

private extension HouseDetailViewController {
    func setRegister() {
        rootView.roomStatusTableView.register(
            RoomStatusTableViewCell.self,
            forCellReuseIdentifier: RoomStatusTableViewCell.reuseIdentifier
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
            
            // TODO: DataBinding
            return cell
        }
        
        return UITableViewCell()
    }
}

extension HouseDetailViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        if tableView == rootView.roomStatusTableView {
            return roomStatusCellHeight
        }
        
        return 0
    }
}
