//
//  PhoneNumberEditViewController.swift
//  Roomie
//
//  Created by 예삐 on 6/27/25.
//

import UIKit
import Combine

import CombineCocoa

final class PhoneNumberEditViewController: BaseViewController {
    private let rootView = PhoneNumberEditView()
    
    private let viewModel: PhoneNumberEditViewModel
    
    private let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    private let phoneNumberTextSubject = PassthroughSubject<String, Never>()
    private let editButtonDidTapSubject = PassthroughSubject<Void, Never>()
    
    private let cancelBag = CancelBag()
    
    private var keyboardHandler: KeyboardConstraintHandler?
    
    init(viewModel: PhoneNumberEditViewModel) {
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
        
        bindViewModel()
        setupKeyboardHandler()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewWillAppearSubject.send(())
    }
    
    // MARK: - Functions

    override func setView() {
        setNavigationBar(with: "연락처 수정하기")
    }
    
    override func setAction() {
        hideKeyboardWhenDidTap()
        
        rootView.phoneNumberTextField
            .controlEventPublisher(for: .editingChanged)
            .sink { [weak self] in
                guard let self = self,
                      let raw = self.rootView.phoneNumberTextField.text else { return }
                let formatted = self.formatPhoneNumber(raw)
                self.rootView.phoneNumberTextField.text = formatted
                self.phoneNumberTextSubject.send(formatted)
            }
            .store(in: cancelBag)
        
        rootView.editButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.editButtonDidTapSubject.send(())
            }
            .store(in: cancelBag)
    }
}

extension PhoneNumberEditViewController {
    func bindViewModel() {
        let input = PhoneNumberEditViewModel.Input(
            viewWillAppearSubject: viewWillAppearSubject.eraseToAnyPublisher(),
            phoneNumberTextSubject: phoneNumberTextSubject.eraseToAnyPublisher(),
            editButtonDidTapSubject: editButtonDidTapSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.previousPhoneNumber
            .receive(on: RunLoop.main)
            .sink { [weak self] phoneNumber in
                guard let self = self else { return }
                self.rootView.phoneNumberTextField.text = phoneNumber
            }
            .store(in: cancelBag)
        
        output.isPhoneNumberValid
            .sink { [weak self] isValid in
                guard let self = self else { return }
                let borderColor = isValid ? UIColor.grayscale5.cgColor : UIColor.actionError.cgColor
                self.rootView.phoneNumberTextField.layer.borderColor = borderColor
                self.rootView.inValidErrorStackView.isHidden = isValid
                
                self.rootView.phoneNumberTextField.shouldShowActionColor = !isValid
            }
            .store(in: cancelBag)
        
        output.isSuccess
            .receive(on: RunLoop.main)
            .sink { [weak self] isSuccess in
                if isSuccess {
                    guard let self = self else { return }
                    self.navigationController?.popViewController(animated: true)
                }
            }
            .store(in: cancelBag)
    }
    
    private func formatPhoneNumber(_ input: String) -> String {
        let digits = input.filter { $0.isNumber }
        let trimmed = String(digits.prefix(11))
        
        switch trimmed.count {
        case 0...3:
            return trimmed
        case 4...7:
            let p1 = trimmed.prefix(3)
            let p2 = trimmed.dropFirst(3)
            return "\(p1)-\(p2)"
        default:
            let p1 = trimmed.prefix(3)
            let middle = trimmed.dropFirst(3)
            let p2 = middle.prefix(4)
            let p3 = middle.dropFirst(4)
            return "\(p1)-\(p2)-\(p3)"
        }
    }
    
    private func setupKeyboardHandler() {
        guard let bottomConstraint = rootView.editButtonBottomConstraint else { return }
        keyboardHandler = KeyboardConstraintHandler(
            containerView: view,
            adjustments: [
                .init(
                    constraint: bottomConstraint,
                    defaultInset: rootView.defaultButtonBottomInset
                )
            ]
        )
        keyboardHandler?.startObserving()
    }
}
