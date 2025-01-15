//
//  TourDateViewController.swift
//  Roomie
//
//  Created by 김승원 on 1/15/25.
//

import UIKit
import Combine

import CombineCocoa

final class TourDateViewController: BaseViewController {
    
    // MARK: - Property
    
    private let rootView = TourDateView()
    
    private let viewModel: TourDateViewModel
    
    private let dateSubject = PassthroughSubject<String, Never>()
    private let messageSubject = PassthroughSubject<String, Never>()
    
    private let cancelBag = CancelBag()
    
    // MARK: - Initializer
    
    init(viewModel: TourDateViewModel) {
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
        rootView.preferredDatePickerView.delegate = self
    }
    
    override func setAction() {
        rootView.messageTextView
            .textPublisher
            .compactMap { $0 }
            .sink { [weak self] message in
                self?.messageSubject.send(message)
            }
            .store(in: cancelBag)
        
        rootView.nextButton
            .tapPublisher
            .sink { [weak self] in
                guard let self else { return }
                let tourCompleteViewController = TourCompleteViewController()
                self.navigationController?.pushViewController(tourCompleteViewController, animated: true)
            }
            .store(in: cancelBag)
    }
}

// MARK: - Functions

private extension TourDateViewController {
    func bindViewModel() {
        let input = TourDateViewModel.Input(
            dateSubject: dateSubject.eraseToAnyPublisher(),
            messageSubject: messageSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.isNextButtonEnabled
            .sink { [weak self] isEnabled in
                self?.rootView.nextButton.isEnabled = isEnabled
            }
            .store(in: cancelBag)
    }
}

// MARK: - DatePickerViewDelegate

extension TourDateViewController: DatePickerViewDelegate {
    func dateDidPick(date: String) {
        dateSubject.send(date)
    }
}

// MARK: - KeyboardObservable

extension TourDateViewController: KeyboardObservable {
    var transformView: UIView { return self.view }
}

