//
//  MyPageViewController.swift
//  Roomie
//
//  Created by 예삐 on 1/9/25.
//

import UIKit
import Combine

final class MyPageViewController: BaseViewController {
    
    // MARK: - UIComponent

    private let rootView = MyPageView()
    
    private let viewModel: MyPageViewModel
    
    private let cancelBag = CancelBag()
    
    // MARK: - Property
    
    private let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    
    // MARK: - Initializer

    init(viewModel: MyPageViewModel) {
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
        setNavigationBar(with: "마이페이지", isBackButtonHidden: true)
    }
}

private extension MyPageViewController {
    func bindViewModel() {
        let input = MyPageViewModel.Input(
            viewWillAppearSubject: viewWillAppearSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.userName
            .receive(on: RunLoop.main)
            .sink { [weak self] name in
                guard let self = self else { return }
                rootView.myPageHeaderButton.nicknameLabel.updateText(name)
            }
            .store(in: cancelBag)
        
        output.socialType
            .receive(on: RunLoop.main)
            .sink { [weak self] socialType in
                guard let self = self else { return }
                rootView.myPageHeaderButton.loginTypeLabel.updateText("\(socialType) 계정 회원")
            }
            .store(in: cancelBag)
    }
}
