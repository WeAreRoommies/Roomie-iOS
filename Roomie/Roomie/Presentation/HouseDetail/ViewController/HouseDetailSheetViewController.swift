//
//  HouseDetailSheetViewController.swift
//  Roomie
//
//  Created by 김승원 on 1/21/25.
//

import UIKit
import Combine

final class HouseDetailSheetViewController: BaseViewController {
    
    // MARK: - Property
    
    private let rootView = HouseDetailSheetView()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = rootView
    }
}
