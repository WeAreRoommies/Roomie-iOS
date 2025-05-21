//
//  OnBoardingPageViewController.swift
//  Roomie
//
//  Created by MaengKim on 5/21/25.
//

import UIKit

final class OnBoardingPageViewController: UIViewController {
    
    // MARK: - Property
    
    private let onBoardingView = OnBoardingScrollView()
    
    let loginView = OnBoardingLoginView()
    
    private let type: OnBoardingType
    
    // MARK: - Initializer
    
    init(type: OnBoardingType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
        
        if type.isLogin {
            self.view = loginView
        } else {
            onBoardingView.configure(with: type)
            self.view = onBoardingView
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    
    func getType() -> OnBoardingType {
        return type
    }
}
