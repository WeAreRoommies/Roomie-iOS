//
//  TourCheckViewController.swift
//  Roomie
//
//  Created by 김승원 on 1/11/25.
//

import UIKit
import Combine

import CombineCocoa

final class TourCheckViewController: BaseViewController {
    
    // MARK: - Property
    
    private let rootView = TourCheckView()

    // MARK: - LifeCycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar(with: "", isBorderHidden: true)
    }
}
