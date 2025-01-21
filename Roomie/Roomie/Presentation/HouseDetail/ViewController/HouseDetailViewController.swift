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
    
    private let navigationBarThreshold = Screen.height(212.0)
    private let navigationTitleThreshold = Screen.height(280.0)
    
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
        
        setRegister()
        
        rootView.safetyLivingFacilityView.dataBind(["침대", "침구", "옷장", "냉장고", "세탁기", "믹서", "드라이기"])
        rootView.kitchenFacilityView.dataBind(["냉장고", "세탁기", "믹서", "드라이기"])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewWillAppearSubject.send(())
        setClearNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        rootView.updateRoomStatusTableViewHeight(roomStatusCellCount, height: roomStatusCellHeight)
        rootView.roomStatusTableView.layoutIfNeeded()
        
        rootView.updateRoommateTableViewHeight(roommateCellCount, height: roommateCellHeight)
    }
    
    override func setView() {
        setNavigationBar(with: "", isBorderHidden: true)
    }
    
    override func setDelegate() {
        rootView.roomStatusTableView.dataSource = self
        rootView.roomStatusTableView.delegate = self
        
        rootView.roommateTableView.dataSource = self
        rootView.roommateTableView.delegate = self
        
        rootView.scrollView.delegate = self
    }
}

// MARK: - Functions

private extension HouseDetailViewController {
    func setClearNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        
        let clearAppearance = UINavigationBarAppearance()
        clearAppearance.configureWithTransparentBackground()
        clearAppearance.shadowColor = nil
        clearAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.grayscale12,
            .font: UIFont.pretendard(.heading5)
        ]
        
        navigationController?.navigationBar.standardAppearance = clearAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = clearAppearance
        navigationController?.navigationBar.compactAppearance = clearAppearance
        
        // 커스텀 border 제거
        let borderIdentifier = "customBorder"
        if let existingBorder = navigationController?.navigationBar.subviews.first(where: { $0.accessibilityIdentifier == borderIdentifier }) {
            existingBorder.removeFromSuperview()
        }
        
        navigationItem.title = nil
    }
    
    func setFilledNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        
        let filledAppearance = UINavigationBarAppearance()
        filledAppearance.configureWithOpaqueBackground()
        filledAppearance.backgroundColor = .grayscale1
        filledAppearance.shadowColor = .grayscale4
        
        filledAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.grayscale12,
            .font: UIFont.pretendard(.heading5)
        ]
        
        navigationController?.navigationBar.standardAppearance = filledAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = filledAppearance
        navigationController?.navigationBar.compactAppearance = filledAppearance
        
        // 커스텀 border 추가
        let borderIdentifier = "customBorder"
        let existingBorder = navigationController?.navigationBar.subviews.first(where: { $0.accessibilityIdentifier == borderIdentifier })
        
        if existingBorder == nil {
            let customBorder = UIView()
            customBorder.accessibilityIdentifier = borderIdentifier
            customBorder.backgroundColor = .grayscale4
            
            navigationController?.navigationBar.addSubview(customBorder)
            
            customBorder.snp.makeConstraints {
                $0.height.equalTo(1)
                $0.leading.trailing.equalToSuperview()
                $0.bottom.equalToSuperview()
            }
        }
    }
    
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

// MARK: - ScrollView Delegate

extension HouseDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        if offsetY > navigationBarThreshold {
            setFilledNavigationBar()
        } else {
            setClearNavigationBar()
        }
        
        if offsetY > navigationTitleThreshold {
            navigationItem.title = "43~50/90~100" // TODO: DataBind
        } else {
            navigationItem.title = nil
        }
    }
}
