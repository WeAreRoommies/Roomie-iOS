//
//  MapFilterViewController.swift
//  Roomie
//
//  Created by 예삐 on 1/11/25.
//

import UIKit
import Combine

final class MapFilterViewController: BaseViewController {
    private let rootView = MapFilterView()
    private let cancelBag = CancelBag()
    
    override func loadView() {
        view = rootView
    }
    
    override func setupView() {
        setupNavigationBar(with: "필터", isBorderHidden: true)
    }
    
    override func setupAction() {
        rootView.filterSegmentedControl
            .publisher(for: \.selectedSegmentIndex)
            .sink { [weak self] selectedIndex in
                guard let self = self else { return }
                self.updateFilterViews(for: selectedIndex)
            }
            .store(in: cancelBag)
    }
}

private extension MapFilterViewController {
    func updateFilterViews(for selectedIndex: Int) {
        switch selectedIndex {
        case 0:
            rootView.filterPriceView.isHidden = false
            rootView.filterRoomView.isHidden = true
            rootView.filterPeriodView.isHidden = true
        case 1:
            rootView.filterPriceView.isHidden = true
            rootView.filterRoomView.isHidden = false
            rootView.filterPeriodView.isHidden = true
        default:
            rootView.filterPriceView.isHidden = true
            rootView.filterRoomView.isHidden = true
            rootView.filterPeriodView.isHidden = false
        }
    }
}
