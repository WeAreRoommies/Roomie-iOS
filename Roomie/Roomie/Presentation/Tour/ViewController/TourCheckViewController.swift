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
        rootView.nextButton
            .tapPublisher
            .sink {
                let tourUserViewController = TourUserViewController()
                self.navigationController?.pushViewController(tourUserViewController, animated: true)
            }
            .store(in: cancelBag)
    }
}
