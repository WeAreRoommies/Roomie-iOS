//
//  TourDateViewController.swift
//  Roomie
//
//  Created by 김승원 on 1/15/25.
//

import UIKit
import Combine

import CombineCocoa

final class TourDateViewController: BaseViewController {
    
    // MARK: - Property
    
    private let rootView = TourDateView()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar(with: "", isBorderHidden: true)
        hideKeyboardWhenDidTap()
    }
    
}
