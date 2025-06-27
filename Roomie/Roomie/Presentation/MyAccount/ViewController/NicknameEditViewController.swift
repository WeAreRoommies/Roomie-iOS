//
//  NicknameEditViewController.swift
//  Roomie
//
//  Created by 예삐 on 6/27/25.
//

import UIKit
import Combine

import CombineCocoa

final class NicknameEditViewController: BaseViewController {
    private let rootView = NicknameEditView()
    
    private let viewModel: NicknameEditViewModel
    
    private let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    private let nicknameTextSubject = PassthroughSubject<String, Never>()
    private let editButtonDidTapSubject = PassthroughSubject<Void, Never>()
    
    private let cancelBag = CancelBag()
    
    private var keyboardHandler: KeyboardConstraintHandler?
    
    init(viewModel: NicknameEditViewModel) {
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
        setNavigationBar(with: "이름 수정하기")
    }
    
    override func setAction() {
        hideKeyboardWhenDidTap()
        
        rootView.nicknameTextField
            .textPublisher
            .compactMap { $0 }
            .sink { [weak self] name in
                guard let self = self else { return }
                self.nicknameTextSubject.send(name)
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

extension NicknameEditViewController {
    func bindViewModel() {
        let input = NicknameEditViewModel.Input(
            viewWillAppearSubject: viewWillAppearSubject.eraseToAnyPublisher(),
            nicknameTextSubject: nicknameTextSubject.eraseToAnyPublisher(),
            editButtonDidTapSubject: editButtonDidTapSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.previousNickname
            .receive(on: RunLoop.main)
            .sink { [weak self] nickname in
                guard let self = self else { return }
                self.rootView.nicknameTextField.text = nickname
            }
            .store(in: cancelBag)
        
        output.isNicknameValid
            .sink { [weak self] isValid in
                guard let self = self else { return }
                let borderColor = isValid ? UIColor.grayscale5.cgColor : UIColor.actionError.cgColor
                self.rootView.nicknameTextField.layer.borderColor = borderColor
                self.rootView.inValidErrorStackView.isHidden = isValid
                
                self.rootView.nicknameTextField.shouldShowActionColor = !isValid
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
