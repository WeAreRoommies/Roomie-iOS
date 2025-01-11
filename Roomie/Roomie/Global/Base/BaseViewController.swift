//
//  BaseViewController.swift
//  Roomie
//
//  Created by 예삐 on 1/7/25.
//

import UIKit

import SnapKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupAction()
        setupDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    /// 네비게이션 바 등 추가적으로 UI와 관련한 작업
    func setupView() {}
    
    /// RootView로부터 액션 설정 (addTarget)
    func setupAction() {}
    
    /// RootView 또는 ViewController 자체로부터 Delegate, DateSource 등 설정
    func setupDelegate() {}
}

extension BaseViewController {
    
    /// 네비게이션 바 커스텀
    func setupNavigationBar(with string: String, isBorderHidden: Bool = false) {
        title = string
        
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = .grayscale1
        barAppearance.shadowColor = nil
        
        barAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.grayscale12,
            .font: UIFont.pretendard(.heading5)
        ]
        
        navigationController?.navigationBar.standardAppearance = barAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
        
        let backButton = UIBarButtonItem(
            image: .icnArrowLeftLine24,
            style: .plain,
            target: self,
            action: #selector(backButtonDidTap)
        ).then {
            $0.tintColor = .grayscale10
        }
        
        navigationItem.leftBarButtonItem = backButton
        
        if !isBorderHidden {
            let identifier = "border"
            guard view.subviews.first(
                where: { $0.accessibilityIdentifier == identifier }
            ) == nil else { return }
            
            let safeArea = view.safeAreaLayoutGuide
            let border = UIView().then {
                $0.backgroundColor = .grayscale4
                $0.accessibilityIdentifier = identifier
            }
            
            view.addSubview(border)
            
            border.snp.makeConstraints {
                $0.top.equalTo(safeArea)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(1)
            }
            
            view.bringSubviewToFront(border)
            
            view.setNeedsLayout()
            view.layoutIfNeeded()
        }
    }
    
    /// 화면 터치 시 키보드 내리기
    func hideKeyboardWhenDidTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UIGestureRecognizerDelegate

extension BaseViewController: UIGestureRecognizerDelegate {
    
    /// 뒤로가기 제스쳐 삽입
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return navigationController?.viewControllers.count ?? 0 > 1
    }
}
