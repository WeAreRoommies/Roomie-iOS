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
    
    private let viewModel: TourDateViewModel
    
    // MARK: - Initializer
    
    init(viewModel: TourDateViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar(with: "", isBorderHidden: true)
        hideKeyboardWhenDidTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObserver()
    }
}

extension TourDateViewController: KeyboardObservable {
    var transformView: UIView { return self.view }
}

