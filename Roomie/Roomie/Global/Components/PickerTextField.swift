//
//  PickerTextField.swift
//  Roomie
//
//  Created by 김승원 on 1/12/25.
//

import UIKit

import Then

final class PickerTextField: UITextField {
    
    // MARK: - Property
    
    static let defaultWidth: CGFloat = Screen.width(335)
    static let defaultHeight: CGFloat = Screen.height(54)
    
    private let datePicker = UIDatePicker()
    
    // MARK: - Initializer
    
    init(placeHolder: String) {
        super.init(frame: .zero)
        
        setTextField(placeHolder: placeHolder)
        setDatePicker()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTextField()
        setDatePicker()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setTextField()
        setDatePicker()
    }
}

// MARK: - Function

private extension PickerTextField {
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
        self.inputView = datePicker
        
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
    
    func setDatePicker() {
        datePicker.do {
            $0.tintColor = .primaryPurple
            $0.backgroundColor = .grayscale1
            $0.preferredDatePickerStyle = .compact
            $0.datePickerMode = .date
            $0.frame = CGRect(x: 0, y: 0, width: 335, height: 400)
            $0.locale = Locale(identifier: "Korean")
        }
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
