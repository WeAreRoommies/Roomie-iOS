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
    
    private let cancelBag = CancelBag()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func setView() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func setAction() {
        rootView.lookOtherButton
            .tapPublisher
            .sink { [weak self] in
                guard let self else { return }
                
                if let targetViewController = navigationController?.viewControllers.first(
                    where: { $0 is HouseDetailViewController }) {
                    navigationController?.popToViewController(targetViewController, animated: true)
                    self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
                }
            }
            .store(in: cancelBag)
        
        rootView.completeButton
            .tapPublisher
            .sink { [weak self] in
                guard let self else { return }
                
                navigationController?.popToRootViewController(animated: true)
                self.tabBarController?.selectedIndex = 0
                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            }
            .store(in: cancelBag)
    }
}
