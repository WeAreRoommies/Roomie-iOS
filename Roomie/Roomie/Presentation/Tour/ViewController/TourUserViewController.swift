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
    
    private let viewModel: TourUserViewModel
    
    private let nameTextSubject = PassthroughSubject<String, Never>()
    private let dateSubject = PassthroughSubject<String, Never>()
    private let genderSubject = PassthroughSubject<Gender, Never>()
    private let phoneNumberTextSubject = PassthroughSubject<String, Never>()
    
    private let nextButtonSubject = PassthroughSubject<Void, Never>()
    
    private let cancelBag = CancelBag()
    
    // MARK: - Initializer
    
    init(viewModel: TourUserViewModel) {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObserver()
    }
    
    override func setView() {
        setNavigationBar(with: "", isBorderHidden: true)
    }
    
    override func setDelegate() {
        rootView.birthPickerView.delegate = self
        rootView.phoneNumberTextField.delegate = self
    }
    
    override func setAction() {
        hideKeyboardWhenDidTap()
        
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
                self?.genderSubject.send(Gender.male)
            }
            .store(in: cancelBag)
        
        rootView.femaleButton
            .tapPublisher
            .sink { [weak self] in
                self?.rootView.maleButton.isSelected = false
                self?.genderSubject.send(Gender.female)
            }
            .store(in: cancelBag)
        
        rootView.phoneNumberTextField
            .controlEventPublisher(for: .editingDidEnd)
            .sink { [weak self] in
                let phoneNumber = self?.rootView.phoneNumberTextField.text ?? ""
                self?.phoneNumberTextSubject.send(phoneNumber)
            }
            .store(in: cancelBag)
        
        rootView.nextButton
            .tapPublisher
            .sink { [weak self] in
                guard let self else { return }
                self.nextButtonSubject.send(())
            }
            .store(in: cancelBag)
    }
}

// MARK: - Functions

private extension TourUserViewController {
    func bindViewModel() {
        let input = TourUserViewModel.Input(
            nameTextSubject: nameTextSubject.eraseToAnyPublisher(),
            dateSubject: dateSubject.eraseToAnyPublisher(),
            genderSubject: genderSubject.eraseToAnyPublisher(),
            phoneNumberTextSubject: phoneNumberTextSubject.eraseToAnyPublisher(),
            nextButtonSubject: nextButtonSubject.eraseToAnyPublisher()
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
        
        output.isNextButtonEnabled
            .sink { [weak self] isEnabled in
                self?.rootView.nextButton.isEnabled = isEnabled
            }
            .store(in: cancelBag)
        
        output.presentNextView
            .sink { [weak self] in
                guard let self else { return }
                let tourDateViewController = TourDateViewController(
                    viewModel: TourDateViewModel(
                        service: HousesService(),
                        builder: TourRequestDTO.Builder.shared,
                        roomID: viewModel.roomID
                    )
                )
                self.navigationController?.pushViewController(tourDateViewController, animated: true)
            }
            .store(in: cancelBag)
    }
}

// MARK: - DatePickerViewDelegate

extension TourUserViewController: DatePickerViewDelegate {
    func dateDidPick(date: String) {
        dateSubject.send(date)
    }
}

// MARK: - KeyboardObservable

extension TourUserViewController: KeyboardObservable {
    var transformView: UIView { return self.view }
}

// MARK: - UITextFieldDelegate

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
