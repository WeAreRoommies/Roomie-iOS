//
//  MapTextField.swift
//  Roomie
//
//  Created by 예삐 on 1/16/25.
//

import UIKit
import Combine

import CombineCocoa
import SnapKit
import Then

/// primaryPurpler 테두리의 textField 컴포넌트입니다.
///
/// 초기화시 placeholder값을 설정할 수 있습니다.
/// 입력상태시 테두리 색상이 변경됩니다.
/// - Parameters:
///     - placeHoder: placeHolder를 나타내는 문자열입니다.

final class MapTextField: UITextField {
    
    // MARK: - Property
    
    static let defaultWidth: CGFloat = Screen.width(305)
    static let defaultHeight: CGFloat = Screen.height(50)
    
    private let cancelBag = CancelBag()
    
    // MARK: - Initializer
    
    init(_ placeHolder: String = "") {
        super.init(frame: .zero)
        
        setTextField(placeHolder: placeHolder)
        setTextFieldBorder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTextField()
        setTextFieldBorder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setTextField()
        setTextFieldBorder()
    }
}

// MARK: - Functions

private extension MapTextField {
    func setTextField(placeHolder: String = "") {
        setText(
            placeholder: placeHolder,
            placeholderColor: .grayscale7,
            textColor: .grayscale12,
            backgroundColor: .grayscale2,
            style: .title1
        )
        addPadding(left: 16, right: 48)
        setLayer(borderWidth: 1, borderColor: .grayscale5, cornerRadius: 8)
        setAutoType()
        
        tintColor = .primaryPurple
    }
    
    func setTextFieldBorder() {
        let textFieldEvent = Publishers.MergeMany(
            controlEventPublisher(for: .editingDidBegin).map { UIColor.primaryPurple.cgColor },
            controlEventPublisher(for: .editingDidEnd).map { UIColor.grayscale5.cgColor },
            controlEventPublisher(for: .editingDidEndOnExit).map { UIColor.grayscale5.cgColor }
        )
        
        textFieldEvent
            .sink { borderColor in
                self.layer.borderColor = borderColor
            }
            .store(in: cancelBag)
    }
}
