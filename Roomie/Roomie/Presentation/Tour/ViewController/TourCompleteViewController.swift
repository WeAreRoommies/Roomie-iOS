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
        
        setNavigationBar(with: "", isBorderHidden: true)
    }
    
    override func setAction() {
        rootView.lookOtherButton
            .tapPublisher
            .sink { [weak self] in
                guard let self else { return }
                
                // TODO: 지도 검색화면으로 (Pop)
            }
            .store(in: cancelBag)
        
        rootView.completeButton
            .tapPublisher
            .sink { [weak self] in
                guard let self else { return }
                
                // TODO: 메인 페이지로 이동 (Pop)
            }
            .store(in: cancelBag)
    }
}
