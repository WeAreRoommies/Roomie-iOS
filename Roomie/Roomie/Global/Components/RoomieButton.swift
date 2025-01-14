//
//  RoomieButton.swift
//  Roomie
//
//  Created by 김승원 on 1/11/25.
//

import UIKit
import Combine

import CombineCocoa

/// primaryPurple 색상의 버튼 컴포넌트입니다.
///
/// 초기화 시 버튼 타이틀과 활성화 상태를 설정할 수 있습니다.
/// isEnabled값에 따라 배경색상을 설정합니다.
///
/// - Parameters:
///     - title: 버튼 제목을 나타내는 문자열입니다.
///     - isEnabled: 버튼 활성화 여부입니다. 디폴트값은 true입니다.
final class RoomieButton: UIButton {
    
    // MARK: - Property
    
    static let defaultHeight: CGFloat = Screen.height(58)
    
    override var isEnabled: Bool {
        didSet {
            updateButtonColor()
        }
    }
    
    private let cancelBag = CancelBag()
    
    // MARK: - Initializer
    
    init(title: String, isEnabled: Bool = true) {
        super.init(frame: .zero)
        
        setButton(with: title, isEnabled: isEnabled)
        setButtonColor()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setButton()
        setButtonColor()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setButton()
        setButtonColor()
    }
}

// MARK: - Functions

private extension RoomieButton {
    func setButton(with title: String = " ", isEnabled: Bool = true) {
        setTitle(title, style: .title2, color: .grayscale1)
        self.isEnabled = isEnabled
        setLayer(borderColor: .grayscale1, cornerRadius: 8)
    }
    
    func setButtonColor() {
        controlEventPublisher(for: .touchDown)
            .map { UIColor.primaryLight1 }
            .sink { buttonColor in
                self.backgroundColor = buttonColor
            }
            .store(in: cancelBag)
        
        Publishers.MergeMany(
            controlEventPublisher(for: .touchUpInside),
            controlEventPublisher(for: .touchUpOutside),
            controlEventPublisher(for: .touchCancel)
        )
        .map { self.isEnabled ? UIColor.primaryPurple : UIColor.grayscale6 }
        .sink { buttonColor in
            self.backgroundColor = buttonColor
        }
        .store(in: cancelBag)
    }
    
    func updateButtonColor() {
        backgroundColor = isEnabled ? .primaryPurple : .grayscale6
    }
}
