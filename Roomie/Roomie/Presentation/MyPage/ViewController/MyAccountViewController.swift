//
//  MyAccountViewController.swift
//  Roomie
//
//  Created by 예삐 on 6/5/25.
//

import UIKit
import Combine

final class MyAccountViewController: BaseViewController {
    
    // MARK: - UIComponent

    private let rootView = MyAccountView()
    
//    private let viewModel: MyAccountViewModel
    
    private let cancelBag = CancelBag()
    
    // MARK: - Initializer

//    init(viewModel: MyPageViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    // MARK: - LifeCycle

    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        bindViewModel()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        self.viewWillAppearSubject.send(())
//    }
    
    // MARK: - Functions

    override func setView() {
        setNavigationBar(with: "나의 계정 정보")
    }
}
