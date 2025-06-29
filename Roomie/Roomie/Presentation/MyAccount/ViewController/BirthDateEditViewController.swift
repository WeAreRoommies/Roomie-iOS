//
//  BirthDateEditViewController.swift
//  Roomie
//
//  Created by 예삐 on 6/27/25.
//

import UIKit
import Combine

import CombineCocoa

final class BirthDateEditViewController: BaseViewController {
    private let rootView = BirthDateEditView()
    
    private let viewModel: BirthDateEditViewModel
    
    private let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    private let birthDateSubject = PassthroughSubject<String, Never>()
    private let editButtonDidTapSubject = PassthroughSubject<Void, Never>()
    
    private let cancelBag = CancelBag()
    
    init(viewModel: BirthDateEditViewModel) {
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
        
        viewWillAppearSubject.send(())
    }
    
    // MARK: - Functions

    override func setView() {
        setNavigationBar(with: "생년월일 수정하기")
    }
    
    override func setDelegate() {
        rootView.birthDatePickerView.delegate = self
    }
    
    override func setAction() {
        rootView.editButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.editButtonDidTapSubject.send(())
            }
            .store(in: cancelBag)
    }
}

extension BirthDateEditViewController {
    func bindViewModel() {
        let input = BirthDateEditViewModel.Input(
            viewWillAppearSubject: viewWillAppearSubject.eraseToAnyPublisher(),
            birthDateSubject: birthDateSubject.eraseToAnyPublisher(),
            editButtonDidTapSubject: editButtonDidTapSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.previousBirthDate
            .receive(on: RunLoop.main)
            .sink { [weak self] birthDate in
                guard let self = self else { return }
                let date: Date = {
                    let formatter = DateFormatter()
                    formatter.locale = Locale(identifier: "ko_KR")
                    formatter.dateFormat = "yyyy-MM-dd"
                    return formatter.date(from: birthDate) ?? Date()
                }()
                
                self.rootView.birthDatePickerView.setDate(date)
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
}

// MARK: - DatePickerViewDelegate

extension BirthDateEditViewController: DatePickerViewDelegate {
    func dateDidPick(date: String) {
        birthDateSubject.send(date)
    }
}
