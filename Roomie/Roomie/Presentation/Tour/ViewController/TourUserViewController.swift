//
//  TourUserViewController.swift
//  Roomie
//
//  Created by 김승원 on 1/12/25.
//

import UIKit
import Combine

import CombineCocoa

final class TourUserViewController: BaseViewController {
    
    // MARK: - Property
    
    private let rootView = TourUserView()
    
    private let viewModel: TourViewModel
    
    private let nameTextSubject = PassthroughSubject<String, Never>()
    private let phoneNumberTextSubject = PassthroughSubject<String, Never>()
    
    private let cancelBag = CancelBag()
    
    // MARK: - Initializer
    
    init(viewModel: TourViewModel) {
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
        bindViewModel()
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
    
    override func setAction() {
        rootView.nameTextField
            .textPublisher
            .compactMap { $0 }
            .sink { [weak self] name in
                self?.nameTextSubject.send(name)
            }
            .store(in: cancelBag)
        
        rootView.maleButton
            .tapPublisher
            .sink { [weak self] in
                self?.rootView.femaleButton.isSelected = false
            }
            .store(in: cancelBag)
        
        rootView.femaleButton
            .tapPublisher
            .sink { [weak self] in
                self?.rootView.maleButton.isSelected = false
            }
            .store(in: cancelBag)
        
        rootView.phoneNumberTextField
            .controlEventPublisher(for: .editingDidEnd)
            .sink { [weak self] in
                let phoneNumber = self?.rootView.phoneNumberTextField.text ?? ""
                self?.phoneNumberTextSubject.send(phoneNumber)
            }
            .store(in: cancelBag)
    }
}

// MARK: - Functions

private extension TourUserViewController {
    func bindViewModel() {
        let input = TourViewModel.Input(
            nameTextSubject: nameTextSubject.eraseToAnyPublisher(),
            phoneNumberTextSubject: phoneNumberTextSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.isPhoneNumberValid
            .sink { [weak self] isValid in
                let borderColor = isValid ? UIColor.grayscale5.cgColor : UIColor.actionError.cgColor
                self?.rootView.phoneNumberTextField.layer.borderColor = borderColor
                self?.rootView.inValidErrorStackView.isHidden = isValid
                
                self?.rootView.phoneNumberTextField.shouldShowActionColor = !isValid
            }
            .store(in: cancelBag)
    }
}

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
