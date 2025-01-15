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
    
    private let viewModel: TourCheckViewModel
    
    private let cancelBag = CancelBag()
    
    // MARK: - Initializer
    
    init(viewModel: TourCheckViewModel) {
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
    }
    
    override func setAction() {
        rootView.nextButton
            .tapPublisher
            .sink { [weak self] in
                guard let self else { return }
                let tourUserViewController = TourUserViewController(viewModel: TourUserViewModel())
                self.navigationController?.pushViewController(tourUserViewController, animated: true)
            }
            .store(in: cancelBag)
    }
}
