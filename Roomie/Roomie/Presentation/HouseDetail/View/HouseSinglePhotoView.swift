//
//  HouseSinglePhotoView.swift
//  Roomie
//
//  Created by 김승원 on 1/22/25.
//

import UIKit

import SnapKit
import Then

final class HouseSinglePhotoView: BaseView {
    
    // MARK: - UIComponent
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let roomTitleLabel = UILabel()
    private let roomStackView = UIStackView()
    
    // MARK: - UISetting
    
    override func setStyle() {
        roomTitleLabel.do {
            $0.setText("각 방 시설", style: .heading5, color: .grayscale12)
        }
        
        roomStackView.do {
            $0.axis = .vertical
            $0.spacing = 12
            $0.alignment = .fill
            $0.distribution = .fill
        }
    }
    
    override func setUI() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(roomTitleLabel, roomStackView)
    }
    
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualToSuperview().priority(.low)
        }
        
        roomTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(Screen.height(24))
        }
        
        roomStackView.snp.makeConstraints {
            $0.top.equalTo(roomTitleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-24)
        }
    }
}

extension HouseSinglePhotoView {
    func fetchRooms(_ rooms: [HouseDetailRoom], with expandIndex: Int) {
        roomStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for index in 0..<rooms.count {
            let isexpanded = (index == expandIndex)
            
            let expandedView = RoomFacilityExpandView(
                title: rooms[index].name,
                status: rooms[index].status
            )
            expandedView.dataBind(rooms[index].facility)
            expandedView.configure(rooms[index].mainImageURL[0])
            expandedView.setExpanded(isexpanded)
            roomStackView.addArrangedSubview(expandedView)
        }
    }
}
