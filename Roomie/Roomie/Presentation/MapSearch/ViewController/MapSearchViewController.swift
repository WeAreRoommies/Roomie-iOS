//
//  MapSearchViewController.swift
//  Roomie
//
//  Created by 예삐 on 1/16/25.
//

import UIKit
import Combine

import CombineCocoa

final class MapSearchViewController: BaseViewController {
    
    private let rootView = MapSearchView()
    
    private let cancelBag = CancelBag()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func setAction() {
        hideKeyboardWhenDidTap()
        
        rootView.searchTextField.becomeFirstResponder()
        
        rootView.backButton
            .tapPublisher
            .sink { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .store(in: cancelBag)
    }
}
