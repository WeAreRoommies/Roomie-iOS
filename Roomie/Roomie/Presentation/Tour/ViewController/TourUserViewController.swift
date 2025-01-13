//
//  TourUserViewController.swift
//  Roomie
//
//  Created by 김승원 on 1/12/25.
//

import UIKit

final class TourUserViewController: BaseViewController {
    
    // MARK: - Property
    
    private let rootView = TourUserView()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar(with: "", isBorderHidden: true)
        hideKeyboardWhenDidTap()
        
    }
    
}
