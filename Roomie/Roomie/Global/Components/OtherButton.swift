//
//  OtherButton.swift
//  Roomie
//
//  Created by 김승원 on 1/16/25.
//

import UIKit
import Combine

import CombineCocoa

/// 다른 방 둘러보기 버튼 컴포넌트입니다.
///
/// /// 초기화 시 버튼 타이틀을 설정할 수 있습니다.
///
/// - Parameters:
///     - title: 버튼 제목을 나타내는 문자열입니다.
final class OtherButton: UIButton {
    
    // MARK: - Property
    
    static let defaultHeight: CGFloat = Screen.height(58)
    static let defaultWidth: CGFloat = Screen.width(173)
    
    private let cancelBag = CancelBag()
    
    // MARK: - Initializer
    
    init(title: String) {
        super.init(frame: .zero)
        
        setButton(with: title)
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

private extension OtherButton {
    func setButton(with title: String = "") {
        setTitle(title, style: .title2, color: .grayscale8)
        setLayer(borderWidth: 1, borderColor: .grayscale6, cornerRadius: 8)
    }
    
    func setButtonColor() {
        controlEventPublisher(for: .touchDown)
            .map { UIColor.grayscale2 }
            .sink { buttonColor in
                self.backgroundColor = buttonColor
            }
            .store(in: cancelBag)
        
        Publishers.MergeMany(
            controlEventPublisher(for: .touchUpInside),
            controlEventPublisher(for: .touchUpOutside),
            controlEventPublisher(for: .touchCancel)
        )
        .map { UIColor.grayscale1 }
        .sink { buttonColor in
            self.backgroundColor = buttonColor
        }
        .store(in: cancelBag)
    }
}
