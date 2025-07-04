//
//  AlertManager.swift
//  Roomie
//
//  Created by 김승원 on 7/4/25.
//

import UIKit

final class AlertManager {
    
    static let shared = AlertManager()
    private init() { }
    
    /// 화면에 알림을 표시합니다
    /// - Parameters:
    ///   - viewController: 알림 표시 대상 UIViewcontroller 인스턴스
    ///   - alertType: Alert타입
    ///   - confirmHandler: 확인 버튼 후 실행할 클로저
    func showAlert(
        on viewController: UIViewController,
        alertType: AlertType,
        confirmHandler: ((UIAlertAction) -> Void)? = nil
    ) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: alertType.title, message: alertType.message, preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(
                title: "확인",
                style: alertType.isDestructiveButtonEnabled ? .destructive : .default,
                handler: confirmHandler
            )
            alert.addAction(confirmAction)
            
            if alertType.isCancelButtonEnabled {
                let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                alert.addAction(cancelAction)
            }
            
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
