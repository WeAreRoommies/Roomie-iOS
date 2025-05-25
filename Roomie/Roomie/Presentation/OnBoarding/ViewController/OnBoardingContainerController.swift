//
//  OnBoardingViewController.swift
//  Roomie
//
//  Created by MaengKim on 5/20/25.
//

import UIKit
import Combine

import CombineCocoa
import SnapKit
import Then

final class OnBoardingViewController: UIViewController {
    
    // MARK: - Property
    
    private let pageViewController: UIPageViewController
    
    private let cancelBag = CancelBag()
    
    private var indicators: [UIView] = []
    
    private let indicatorStackView = UIStackView()
    
    private var pages: [UIViewController] = []
    
    private let pageControl = UIPageControl()
    
    private let viewModel: OnBoardingViewModel
    
    private let homeViewModel: HomeViewModel

    private let pageIndexSubject = PassthroughSubject<OnBoardingType, Never>()
    
    // MARK: - UIComponent
    
    private let startButton = UIButton(type: .system)
    
    // MARK: - Initializer
    
    init(viewModel: OnBoardingViewModel, homeViewModel: HomeViewModel) {
        self.viewModel = viewModel
        self.homeViewModel = homeViewModel
        self.pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        setPage()
        setPageViewController()
        setPageIndicators()
        setStartButton()
        setAction()
        setDelegate()
        bindViewModel()
    }
}

// MARK: - Function

private extension OnBoardingViewController {
    
    func setStartButton() {
        startButton.do {
            $0.setTitle("바로 시작하기", style: .title2, color: .grayscale1)
            $0.backgroundColor = .primaryPurple
            $0.layer.cornerRadius = 8
        }
    }
    
    func setDelegate() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }
    
    func setAction() {
        startButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                let navigationViewController = LoginViewController()
                self.navigationController?.pushViewController(navigationViewController, animated: true)
            }
            .store(in: cancelBag)
    }
    
    func setPage() {
        pages = OnBoardingType.onBoardingCases.map { type in
            let viewController = UIViewController()
            viewController.view = OnBoardingStepView().then {
                $0.configure(with: type)
            }
            return viewController
        }
    }
    
    func setPageViewController() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        
        pageViewController.view.addSubview(startButton)
        startButton.snp.makeConstraints{
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(45)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Screen.width(335))
            $0.height.equalTo(Screen.height(58))
        }
        
        pageViewController.didMove(toParent: self)
        pageViewController.setViewControllers([pages[0]], direction: .forward, animated: true)
    }
    
    func setPageIndicators() {
        indicatorStackView.axis = .horizontal
        indicatorStackView.alignment = .center
        indicatorStackView.distribution = .equalSpacing
        indicatorStackView.spacing = 8
        
        OnBoardingType.onBoardingCases.forEach { _ in
            let dot = UIView()
            dot.backgroundColor = .grayscale5
            dot.layer.cornerRadius = 4
            dot.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 8, height: 8))
            }
            indicators.append(dot)
            indicatorStackView.addArrangedSubview(dot)
        }
        
        view.addSubview(indicatorStackView)
        indicatorStackView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(60)
            $0.centerX.equalToSuperview()
        }
    }
    
    func updatePageIndicators(for type: OnBoardingType) {
        if type.isLogin {
            indicatorStackView.isHidden = true
            startButton.isHidden = true
        } else {
            indicatorStackView.isHidden = false
            startButton.isHidden = false
        }
        
        for (index, dot) in indicators.enumerated() {
            if index == OnBoardingType.allCases.firstIndex(of: type) {
                dot.backgroundColor = .primaryPurple
                dot.layer.cornerRadius = 4
                dot.snp.remakeConstraints {
                    $0.size.equalTo(CGSize(width: 16, height: 8))
                }
            } else {
                dot.backgroundColor = .grayscale5
                dot.layer.cornerRadius = 4
                dot.snp.remakeConstraints {
                    $0.size.equalTo(CGSize(width: 8, height: 8))
                }
            }
        }
    }
    
    func bindViewModel() {
        let input = OnBoardingViewModel.Input(
            currentPageSubject: pageIndexSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.currentPage
            .sink { [weak self] type in
                self?.updatePageIndicators(for: type)
            }
            .store(in: cancelBag)
    }
}

extension OnBoardingViewController:
    UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController)
    -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else { return nil }
        return pages[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController)
    -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else {return nil}
        return pages[index+1]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard let currentViewController = pageViewController.viewControllers?.first,
            let currentView = currentViewController.view as? OnBoardingStepView,
           let type = currentView.type else {
            return
        }
        pageIndexSubject.send(type)
    }
}
