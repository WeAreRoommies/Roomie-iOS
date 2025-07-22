//
//  AlertBuilder.swift
//  Roomie
//
//  Created by 김승원 on 7/22/25.
//

import UIKit

final class AlertBuilder {
    
    // MARK: - Properties
    
    private let baseViewController: UIViewController
    private let alertViewController = RoomieAlertViewController()
    
    private var alertTitle: String?
    private var confirmAction: AlertAction?
    private var cancelAction: AlertAction?
    
    // MARK: - Initializer
    
    init(viewController: UIViewController) {
        self.baseViewController = viewController
    }
    
    // MARK: - Functions
    
    func setTitle(_ alertTitle: String) -> AlertBuilder {
        self.alertTitle = alertTitle
        return self
    }
    
    func setConfirmAction(_ text: String, action: (() -> Void)? = nil) -> AlertBuilder {
        self.confirmAction = AlertAction(text: text, action: action)
        return self
    }
    
    func setCancelAction(_ text: String, action: (() -> Void)? = nil) -> AlertBuilder {
        self.cancelAction = AlertAction(text: text, action: action)
        return self
    }
    
    @discardableResult
    func build() -> Self {
        alertViewController.modalPresentationStyle = .overFullScreen
        alertViewController.modalTransitionStyle = .crossDissolve
        
        alertViewController.alertTitle = alertTitle
        alertViewController.confirmAction = confirmAction
        alertViewController.cancelAction = cancelAction
        
        baseViewController.present(alertViewController, animated: true)
        return self
    }
}

// MARK: - RoomieAlertViewController

final class RoomieAlertViewController: UIViewController {
    
    var alertTitle: String?
    var confirmAction: AlertAction?
    var cancelAction: AlertAction?
    
    private let alertContainer = UIView()
    private let alertTitleLabel = UILabel()
    private let confirmButton = UIButton()
    private let cancelButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setUI()
        setLayout()
        setAction()
    }
    
    private func setStyle() {
        view.do {
            $0.backgroundColor = .transpGray1260
            $0.isUserInteractionEnabled = true
        }
        
        alertContainer.do {
            $0.backgroundColor = .grayscale1
            $0.layer.cornerRadius = 8
            $0.layer.masksToBounds = true
        }
        
        alertTitleLabel.do {
            $0.setText(alertTitle ?? " ", style: .body6, color: .grayscale12)
            $0.numberOfLines = 0
        }
        
        confirmButton.do {
            $0.setTitle(confirmAction?.text ?? " ", style: .body5, color: .grayscale1)
            
            var configuration = UIButton.Configuration.filled()
            configuration.baseBackgroundColor = .primaryPurple
            configuration.baseForegroundColor = .grayscale1
            configuration.contentInsets = NSDirectionalEdgeInsets(
                top: Screen.height(8),
                leading: Screen.width(16),
                bottom: Screen.height(8),
                trailing: Screen.width(16)
            )
            configuration.cornerStyle = .fixed
            configuration.background.cornerRadius = 6
            
            $0.configuration = configuration
        }
        
        cancelButton.do {
            $0.setTitle(cancelAction?.text ?? " ", style: .body5, color: .grayscale12)
            
            var configuration = UIButton.Configuration.filled()
            configuration.baseBackgroundColor = .grayscale4
            configuration.baseForegroundColor = .grayscale12
            configuration.contentInsets = NSDirectionalEdgeInsets(
                top: Screen.height(8),
                leading: Screen.width(16),
                bottom: Screen.height(8),
                trailing: Screen.width(16)
            )
            configuration.cornerStyle = .fixed
            configuration.background.cornerRadius = 6
            
            $0.configuration = configuration
        }
    }
    
    private func setUI() {
        view.addSubview(alertContainer)
        alertContainer.addSubviews(
            alertTitleLabel,
            confirmButton,
            cancelButton
        )
    }
    
    private func setLayout() {
        alertContainer.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(Screen.width(257))
            $0.height.greaterThanOrEqualTo(Screen.height(108))
        }
        
        alertTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Screen.height(14))
            $0.horizontalEdges.equalToSuperview().inset(Screen.width(16))
        }
        
        confirmButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Screen.width(16))
            $0.bottom.equalToSuperview().inset(Screen.height(14))
            $0.height.equalTo(Screen.height(34))
        }
        
        cancelButton.snp.makeConstraints {
            $0.trailing.equalTo(confirmButton.snp.leading).offset(-Screen.width(6))
            $0.bottom.equalToSuperview().inset(Screen.height(14))
            $0.height.equalTo(Screen.height(34))
            $0.top.greaterThanOrEqualTo(alertTitleLabel.snp.bottom).offset(Screen.height(28)).priority(.medium)
            $0.top.greaterThanOrEqualTo(alertTitleLabel.snp.bottom).offset(Screen.height(22)).priority(.high)
        }
    }
    
    private func setAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundDidTap))
        view.addGestureRecognizer(tapGesture)
        
        confirmButton.addTarget(self, action: #selector(alertButtonDidTap), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(alertButtonDidTap), for: .touchUpInside)
    }
    
    @objc
    private func backgroundDidTap() {
        dismiss(animated: true)
    }
    
    @objc
    private func alertButtonDidTap(_ sender: UIButton) {
        sender == confirmButton ? confirmAction?.action?() : cancelAction?.action?()
        dismiss(animated: true)
    }
}

// MARK: - AlertAction

struct AlertAction {
    var text: String
    var action: (() -> Void)?
}
