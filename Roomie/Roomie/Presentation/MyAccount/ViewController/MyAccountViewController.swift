//
//  MyAccountViewController.swift
//  Roomie
//
//  Created by 예삐 on 6/5/25.
//

import UIKit
import Combine

import CombineCocoa

final class MyAccountViewController: BaseViewController {
    
    // MARK: - UIComponent

    private let rootView = MyAccountView()
    
    private let viewModel: MyAccountViewModel
    
    private let cancelBag = CancelBag()
    
    // MARK: - Property
    
    private let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    private let logoutButtonDidTapSubject = PassthroughSubject<Void, Never>()
    private let signoutButtonDidTapSubject = PassthroughSubject<Void, Never>()
    
    // MARK: - Initializer

    init(viewModel: MyAccountViewModel) {
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
        
        self.viewWillAppearSubject.send(())
    }
    
    // MARK: - Functions

    override func setView() {
        setNavigationBar(with: "나의 계정 정보")
    }
    
    override func setAction() {
        rootView.nameCellButton.button
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                let nameEditViewController = NameEditViewController(
                    viewModel: NameEditViewModel(service: MyAccountService())
                )
                nameEditViewController.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(nameEditViewController, animated: true)
            }
            .store(in: cancelBag)
        
        rootView.nicknameCellButton.button
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                let nicknameEditViewController = NicknameEditViewController(
                    viewModel: NicknameEditViewModel(service: MyAccountService())
                )
                nicknameEditViewController.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(nicknameEditViewController, animated: true)
            }
            .store(in: cancelBag)
        
        rootView.birthDateCellButton.button
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                let birthDateEditViewController = BirthDateEditViewController(
                    viewModel: BirthDateEditViewModel(service: MyAccountService())
                )
                birthDateEditViewController.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(birthDateEditViewController, animated: true)
            }
            .store(in: cancelBag)
        
        rootView.phoneNumberCellButton.button
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                let phoneNumberEditViewController = PhoneNumberEditViewController(
                    viewModel: PhoneNumberEditViewModel(service: MyAccountService())
                )
                phoneNumberEditViewController.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(phoneNumberEditViewController, animated: true)
            }
            .store(in: cancelBag)
        
        rootView.genderCellButton.button
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                let genderEditViewController = GenderEditViewController(
                    viewModel: GenderEditViewModel(service: MyAccountService())
                )
                genderEditViewController.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(genderEditViewController, animated: true)
            }
            .store(in: cancelBag)
        
        rootView.logoutButton
            .tapPublisher
            .sink { [weak self] in
                guard let self else { return }
                AlertManager.shared.showAlert(
                    on: self,
                    alertType: .logout
                ) { _ in
                    self.logoutButtonDidTapSubject.send()
                }
            }
            .store(in: cancelBag)
        
        rootView.signoutButton
            .tapPublisher
            .sink { [weak self] in
                guard let self else { return }
                AlertManager.shared.showAlert(
                    on: self,
                    alertType: .signout
                ) { _ in
                    self.signoutButtonDidTapSubject.send()
                }
            }
            .store(in: cancelBag)
    }
}

private extension MyAccountViewController {
    func bindViewModel() {
        let input = MyAccountViewModel.Input(
            viewWillAppearSubject: viewWillAppearSubject.eraseToAnyPublisher(),
            logoutButtonDidTapSubject: logoutButtonDidTapSubject.eraseToAnyPublisher(),
            signoutButtonDidTapSubject: signoutButtonDidTapSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.nickname
            .receive(on: RunLoop.main)
            .sink { [weak self] nickname in
                guard let self = self else { return }
                rootView.nicknameCellButton.contentLabel.updateText(nickname)
            }
            .store(in: cancelBag)
        
        output.socialType
            .receive(on: RunLoop.main)
            .sink { [weak self] socialType in
                guard let self = self else { return }
                rootView.socialTypeView.configure(socialType: socialType)
            }
            .store(in: cancelBag)
        
        output.name
            .receive(on: RunLoop.main)
            .sink { [weak self] name in
                guard let self = self else { return }
                rootView.nameCellButton.contentLabel.updateText(name)
            }
            .store(in: cancelBag)
        
        output.birthDate
            .receive(on: RunLoop.main)
            .sink { [weak self] birth in
                guard let self = self else { return }
                rootView.birthDateCellButton.contentLabel.updateText(birth)
            }
            .store(in: cancelBag)
        
        output.phoneNumber
            .receive(on: RunLoop.main)
            .sink { [weak self] contact in
                guard let self = self else { return }
                rootView.phoneNumberCellButton.contentLabel.updateText(contact)
            }
            .store(in: cancelBag)
        
        output.gender
            .receive(on: RunLoop.main)
            .sink { [weak self] gender in
                guard let self = self else { return }
                rootView.genderCellButton.contentLabel.updateText(gender)
            }
            .store(in: cancelBag)
    }
}
