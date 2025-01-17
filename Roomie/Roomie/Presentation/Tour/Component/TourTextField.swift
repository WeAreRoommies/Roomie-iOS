//
//  TourTextField.swift
//  Roomie
//
//  Created by 김승원 on 1/12/25.
//

import UIKit
import Combine

import CombineCocoa
import SnapKit
import Then

final class TourTextField: UITextField {
    
    // MARK: - Property
    
    static let defaultWidth: CGFloat = Screen.width(335)
    static let defaultHeight: CGFloat = Screen.height(54)
    var shouldShowActionColor: Bool = false
    
    private let cancelBag = CancelBag()
    
    // MARK: - Initializer
    
    init(_ placeHolder: String = "", isErrorExist: Bool = false) {
        super.init(frame: .zero)
        
        setTextField(placeHolder: placeHolder, isErrorExist: isErrorExist)
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

private extension TourTextField {
    func setTextField(placeHolder: String = "", isErrorExist: Bool = false) {
        setText(
            placeholder: placeHolder,
            textColor: .grayscale12,
            backgroundColor: .grayscale2,
            style: .body1
        )
        addPadding(left: 16, right: 16)
        setLayer(borderWidth: 1, borderColor: .grayscale5, cornerRadius: 8)
        setAutoType()
        
        tintColor = .primaryPurple
    }
    
    func setTextFieldBorder() {
        let textFieldEvent = Publishers.MergeMany(
            controlEventPublisher(for: .editingDidBegin).map {
                self.shouldShowActionColor ? UIColor.actionError.cgColor : UIColor.primaryPurple.cgColor
            },
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
