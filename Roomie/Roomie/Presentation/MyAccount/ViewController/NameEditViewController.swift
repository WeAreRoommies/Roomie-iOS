//
//  NameEditViewController.swift
//  Roomie
//
//  Created by 예삐 on 6/27/25.
//

import UIKit
import Combine

import CombineCocoa

final class NameEditViewController: BaseViewController {
    private let rootView = NameEditView()
    
    private let viewModel: NameEditViewModel
    
    private let nameTextSubject = PassthroughSubject<String, Never>()
    
    private let cancelBag = CancelBag()
    
    init(viewModel: NameEditViewModel) {
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
    
    // MARK: - Functions

    override func setView() {
        setNavigationBar(with: "이름 수정하기")
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
    }
}

extension NameEditViewController {
    func bindViewModel() {
        let input = NameEditViewModel.Input(
            nameTextSubject: nameTextSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.isNameValid
            .sink { [weak self] isValid in
                let borderColor = isValid ? UIColor.grayscale5.cgColor : UIColor.actionError.cgColor
                self?.rootView.nameTextField.layer.borderColor = borderColor
                self?.rootView.inValidErrorStackView.isHidden = isValid
                
                self?.rootView.nameTextField.shouldShowActionColor = !isValid
            }
            .store(in: cancelBag)
    }
}
