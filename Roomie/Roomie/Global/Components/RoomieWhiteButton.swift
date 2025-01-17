//
//  RommieWhiteButton.swift
//  Roomie
//
//  Created by 예삐 on 1/16/25.
//

import UIKit
import Combine

import CombineCocoa

/// grayscale1 색상의 버튼 컴포넌트입니다.
///
/// 초기화 시 버튼 타이틀을 설정할 수 있습니다.
///
/// - Parameters:
///     - title: 버튼 제목을 나타내는 문자열입니다.
final class RoomieWhiteButton: UIButton {
    
    // MARK: - Property
    
    static let defaultWidth: CGFloat = Screen.height(116)
    static let defaultHeight: CGFloat = Screen.height(58)
    
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

private extension RoomieWhiteButton {
    func setButton(with title: String = "") {
        setTitle(title, style: .title2, color: .grayscale12)
        setLayer(borderWidth: 1, borderColor: .grayscale4, cornerRadius: 8)
    }
    
    func setButtonColor() {
        controlEventPublisher(for: .touchDown)
            .map { UIColor.grayscale3 }
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
