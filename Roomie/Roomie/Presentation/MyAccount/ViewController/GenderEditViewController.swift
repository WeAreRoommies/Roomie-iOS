//
//  GenderEditViewController.swift
//  Roomie
//
//  Created by 예삐 on 6/27/25.
//

import UIKit
import Combine

import CombineCocoa

final class GenderEditViewController: BaseViewController {
    private let rootView = GenderEditView()
    
    private let viewModel: GenderEditViewModel
    
    private let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    private let maleButtonDidTapSubject = PassthroughSubject<Void, Never>()
    private let femaleButtonDidTapSubject = PassthroughSubject<Void, Never>()
    private let editButtonDidTapSubject = PassthroughSubject<Void, Never>()
    
    private let cancelBag = CancelBag()
    
    init(viewModel: GenderEditViewModel) {
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
        setNavigationBar(with: "성별 수정하기")
    }
    
    override func setAction() {
        rootView.maleButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.maleButtonDidTapSubject.send(())
            }
            .store(in: cancelBag)
        
        rootView.femaleButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.femaleButtonDidTapSubject.send(())
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

extension GenderEditViewController {
    func bindViewModel() {
        let input = GenderEditViewModel.Input(
            viewWillAppearSubject: viewWillAppearSubject.eraseToAnyPublisher(),
            maleButtonDidTapSubject: maleButtonDidTapSubject.eraseToAnyPublisher(),
            femaleButtonDidTapSubject: femaleButtonDidTapSubject.eraseToAnyPublisher(),
            editButtonDidTapSubject: editButtonDidTapSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.previousGender
            .receive(on: RunLoop.main)
            .sink { [weak self] gender in
                guard let self = self else { return }
                self.rootView.maleButton.isSelected = (gender == Gender.male.genderString)
                self.rootView.femaleButton.isSelected = (gender == Gender.female.genderString)
            }
            .store(in: cancelBag)
        
        output.gender
            .receive(on: RunLoop.main)
            .sink { [weak self] gender in
                guard let self = self else { return }
                self.rootView.maleButton.isSelected   = (gender == Gender.male.genderString)
                self.rootView.femaleButton.isSelected = (gender == Gender.female.genderString)
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
