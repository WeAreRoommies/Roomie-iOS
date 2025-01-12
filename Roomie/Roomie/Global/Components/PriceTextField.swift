//
//  PriceTextField.swift
//  Roomie
//
//  Created by 예삐 on 1/12/25.
//

import UIKit
import Combine

import CombineCocoa
import Then
import SnapKit

final class PriceTextField: UITextField {
    static let defaultWidth = Screen.width(160)
    static let defaultHeight = Screen.height(44)
    
    private let unitLabel = UILabel()
    
    private let cancelBag = CancelBag()
    
    init(placeHolder: String) {
        super.init(frame: .zero)
        
        setStyle()
        setUI()
        setLayout()
        
        setupTextField(placeHolder: placeHolder)
        setupTextFieldBorder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
        
        setupTextField()
        setupTextFieldBorder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setStyle()
        setUI()
        setLayout()
        
        setupTextField()
        setupTextFieldBorder()
    }
    
    private func setStyle() {
        unitLabel.do {
            $0.setText("만원", style: .body3, color: .grayscale10)
        }
    }
    
    private func setUI() {
        addSubview(unitLabel)
    }
    
    private func setLayout() {
        unitLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}

private extension PriceTextField {
    func setupTextField(placeHolder: String = "text") {
        setText(
            placeholder: placeHolder,
            placeholderColor: .grayscale6,
            textColor: .grayscale12,
            backgroundColor: .grayscale2,
            style: .body1
        )
        addPadding(left: 16, right: 44)
        setLayer(borderWidth: 1, borderColor: .grayscale5, cornerRadius: 8)
        
        textAlignment = .right
        keyboardType = .numberPad
        delegate = self
    }
    
    func setupTextFieldBorder() {
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

extension PriceTextField: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
