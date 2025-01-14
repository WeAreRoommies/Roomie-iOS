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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObserver()
    }
    
    override func setDelegate() {
        rootView.phoneNumberTextField.delegate = self
    }
}

// MARK: - Functions

extension TourUserViewController: KeyboardObservable {
    var transformView: UIView { return self.view }
}

extension TourUserViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
