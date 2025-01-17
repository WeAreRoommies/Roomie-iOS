//
//  MapSearchTextField.swift
//  Roomie
//
//  Created by 예삐 on 1/16/25.
//

import UIKit
import Combine

import CombineCocoa
import SnapKit
import Then

final class MapSearchTextField: UITextField {
    
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

private extension MapSearchTextField {
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
