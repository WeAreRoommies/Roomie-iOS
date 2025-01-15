//
//  TourCompleteViewController.swift
//  Roomie
//
//  Created by 김승원 on 1/16/25.
//

import UIKit
import Combine

import CombineCocoa

final class TourCompleteViewController: BaseViewController {
    
    // MARK: - Property
    
    private let rootView = TourCompleteView()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar(with: "", isBorderHidden: true)
    }
}
