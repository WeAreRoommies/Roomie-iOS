//
//  BasicTextField.swift
//  Roomie
//
//  Created by 김승원 on 1/12/25.
//

import UIKit

final class BasicTextField: UITextField {
    
    // MARK: - Property
    
    static let defaultWidth: CGFloat = Screen.width(335)
    static let defaultHeight: CGFloat = Screen.height(54)
    
    // MARK: - Initializer
    
    init(placeHolder: String) {
        super.init(frame: .zero)
        
        setTextField(placeHolder: placeHolder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setTextField()
    }
}

// MARK: - Function

private extension BasicTextField {
    func setTextField(placeHolder: String = "placeHolder") {
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
        
        addTarget(
            self,
            action: #selector(textFieldDidBeginEditing),
            for: .editingDidBegin
        )
        
        addTarget(
            self,
            action: #selector(textFieldDidEndEditing),
            for: .editingDidEnd
        )
    }
    
    @objc
    func textFieldDidBeginEditing() {
        layer.borderColor = UIColor.primaryPurple.cgColor
    }
    
    @objc
    func textFieldDidEndEditing() {
        layer.borderColor = UIColor.grayscale5.cgColor
    }
    
}
