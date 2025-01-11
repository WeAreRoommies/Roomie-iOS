//
//  CustomButton.swift
//  Roomie
//
//  Created by 김승원 on 1/11/25.
//

import UIKit

/// primaryPurple 색상의 버튼 컴포넌트입니다.
///
/// 초기화 시 버튼 타이틀과 활성화 상태를 설정할 수 있습니다.
/// isEnabled값에 따라 배경색상을 설정합니다.
///
/// - Parameters:
///     - title: 버튼 제목을 나타내는 문자열입니다.
///     - isEnabled: 버튼 활성화 여부입니다. 디폴트값은 true입니다.
final class CustomButton: UIButton {
    
    // MARK: - Property
    
    static let defaultHeight: CGFloat = Screen.height(58)
    
    override var isEnabled: Bool {
        didSet {
            updateButtonColor()
        }
    }
    
    // MARK: - Initializer
    
    init(title: String, isEnabled: Bool = true) {
        super.init(frame: .zero)
        
        setButton(with: title, isEnabled: isEnabled)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setButton()
    }
}

// MARK: - Function

private extension CustomButton {
    func setButton(with title: String = " ", isEnabled: Bool = true) {
        setTitle(title, style: .title2, color: .grayscale1)
        self.isEnabled = isEnabled
        layer.cornerRadius = 8
        
        addTarget(
            self,
            action: #selector(buttonPressed),
            for: .touchDown
        )
        addTarget(
            self,
            action: #selector(buttonReleased),
            for: [.touchUpInside,.touchUpOutside,.touchCancel]
        )
    }
    
    func updateButtonColor() {
        backgroundColor = isEnabled ? .primaryPurple : .grayscale6
    }
    
    @objc
    func buttonPressed() {
        backgroundColor = .primaryLight1
    }
    
    @objc
    func buttonReleased() {
        updateButtonColor()
    }
}
