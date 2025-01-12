//
//  MapFilterView.swift
//  Roomie
//
//  Created by 예삐 on 1/11/25.
//

import UIKit

import SnapKit
import Then

final class MapFilterView: BaseView {
    
    // MARK: - UIComponent
    
    private let seperatorView = UIView()
    let filterSegmentedControl = FilterSegmentedControl(items: ["금액", "방 형태", "계약기간"])
    
    let filterPriceView = FilterPriceView()
    let filterRoomView = FilterRoomView()
    let filterPeriodView = FilterPeriodView()
    
    // MARK: - UISetting
    
    override func setStyle() {
        seperatorView.do {
            $0.backgroundColor = .grayscale4
        }
    }
    
    override func setUI() {
        addSubviews(
            seperatorView,
            filterSegmentedControl,
            filterPriceView,
            filterRoomView,
            filterPeriodView
        )
    }
    
    override func setLayout() {
        filterSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(4)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(36)
        }
        
        seperatorView.snp.makeConstraints {
            $0.top.equalTo(filterSegmentedControl.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        filterPriceView.snp.makeConstraints {
            $0.top.equalTo(seperatorView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        filterRoomView.snp.makeConstraints {
            $0.top.equalTo(seperatorView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        filterPeriodView.snp.makeConstraints {
            $0.top.equalTo(seperatorView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
