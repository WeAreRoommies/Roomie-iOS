//
//  LoginViewController.swift
//  Roomie
//
//  Created by MaengKim on 5/25/25.
//

import UIKit

import SnapKit
import Combine

final class LoginViewController: BaseViewController {
    
    // MARK: - Property
    
    private let rootView = LoginView()
    
    private let kakaoLoginButtonDidTap = PassthroughSubject<Void, Never>()
    
    private let viewModel: LoginViewModel
    
    private let cancelBag = CancelBag()
    
    // MARK: - Initializer

    init(viewModel: LoginViewModel) {
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
    
    override func setAction() {
        rootView.kakaoLoginButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.kakaoLoginButtonDidTap.send()
            }
            .store(in: cancelBag)
    }
}

private extension LoginViewController {
    func bindViewModel() {
        let input = LoginViewModel.Input(
            kakaoLoginButtonDidTapSubject: kakaoLoginButtonDidTap.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.isLoginSucceedSubject
            .sink { [weak self] isSucceed in
                guard let self = self else { return }
                if isSucceed {
                    self.navigationController?.pushViewController(MainTabBarController(), animated: true)
                }
            }
            .store(in: cancelBag)
    }
}
