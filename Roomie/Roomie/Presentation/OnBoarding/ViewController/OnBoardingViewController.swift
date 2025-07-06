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

final class OnBoardingViewController: BaseViewController {
    
    // MARK: - Property
    
    private let pageViewController: UIPageViewController
    
    private let cancelBag = CancelBag()
    
    private var indicators: [UIView] = []
    
    private let indicatorStackView = UIStackView()
    
    private var pages: [UIViewController] = []
    
    private let pageControl = UIPageControl()
    
    private var type: OnBoardingType?
    
    private var currentIndex: Int = 0
    
    // MARK: - UIComponent
    
    private let startButton = UIButton(type: .system)
    
    // MARK: - Initializer
    
    init() {
        self.type = nil
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
        
        setPage()
        setPageViewController()
        setPageIndicators()
        setStartButton()
    }
    
    override func setView() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func setDelegate() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }
    
    override func setAction() {
        startButton
            .tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                let navigationViewController = LoginViewController(
                    viewModel: LoginViewModel(service: AuthService())
                )
                self.navigationController?.pushViewController(navigationViewController, animated: true)
            }
            .store(in: cancelBag)
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
    
    func setPage() {
        pages = OnBoardingType.allCases.map { type in
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
        
        if let scrollView = pageViewController.view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView {
            scrollView.delegate = self
        }
    }
    
    func setPageIndicators() {
        indicatorStackView.axis = .horizontal
        indicatorStackView.alignment = .center
        indicatorStackView.distribution = .equalSpacing
        indicatorStackView.spacing = 8
        
        OnBoardingType.allCases.enumerated().forEach { index, _ in
            let dot = UIView()
            
            if index == 0 {
                dot.backgroundColor = .primaryPurple
                dot.layer.cornerRadius = 4
                dot.snp.remakeConstraints {
                    $0.size.equalTo(CGSize(width: 16, height: 8))
                }
            } else {
                dot.backgroundColor = .grayscale5
                dot.layer.cornerRadius = 4
                dot.snp.makeConstraints {
                    $0.size.equalTo(CGSize(width: 8, height: 8))
                }
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
            let type = currentView.type,
        let index = OnBoardingType.allCases.firstIndex(of: type)
        else {
            return
        }
        
        currentIndex = index
        updatePageIndicators(for: type)
    }
}

extension OnBoardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isEdgePage = (currentIndex == 0) || (currentIndex == OnBoardingType.allCases.count - 1)
        scrollView.bounces = !isEdgePage
    }
}
