//
//  TourTextView.swift
//  Roomie
//
//  Created by 김승원 on 1/15/25.
//

import UIKit
import Combine

import CombineCocoa
import SnapKit
import Then

final class TourTextView: UITextView {
    
    // MARK: - UIComopnent
    private let placeholderLabel = UILabel()
    
    // MARK: - Property
    
    static let defaultWidth: CGFloat = Screen.width(335)
    static let defaultHeight: CGFloat = Screen.height(112)
    
    private var placeholderText: String = ""

    private let textViewInset: CGFloat = 16
    
    private let placeholderHiddenSubject = PassthroughSubject<Bool, Never>()
    
    private let cancelBag = CancelBag()
    
    // MARK: - Initializer
    
    init(placeholder: String) {
        self.placeholderText = placeholder
        super.init(frame: .zero, textContainer: nil)
        
        setPlaceholder()
        setStyle()
        setUI()
        setLayout()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        setPlaceholder()
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setPlaceholder()
        setStyle()
        setUI()
        setLayout()
    }
    
    // MARK: - UISetting
    
    private func setStyle() {
        self.do {
            $0.setText(
                textColor: .grayscale12,
                backgroundColor: .grayscale2,
                style: .title1
            )
            $0.setLayer(
                borderWidth: 1,
                borderColor: .grayscale5,
                cornerRadius: 8
            )
            $0.addInset(
                top: textViewInset,
                left: textViewInset,
                bottom: textViewInset,
                right: textViewInset
            )
            $0.setAutoType()
        }
        
        placeholderLabel.do {
            $0.setText(placeholderText, style: .body1, color: .grayscale6)
        }
    }
    
    private func setUI() {
        addSubview(placeholderLabel)
    }
    
    private func setLayout() {
        placeholderLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
        }
    }
}

// MARK: - Functions

private extension TourTextView {
    func setPlaceholder() {
        
        didBeginEditingPublisher
            .sink { [weak self] in
                guard let self else { return }
                self.layer.borderColor = UIColor.primaryPurple.cgColor
                self.placeholderHiddenSubject.send(true)
            }
            .store(in: cancelBag)
        
        didEndEditingPublisher
            .map { self.text.isEmpty }
            .sink { [weak self] isTextViewEmpty in
                guard let self else { return }
                self.layer.borderColor = UIColor.grayscale5.cgColor
                self.placeholderHiddenSubject.send(!isTextViewEmpty)
            }
            .store(in: cancelBag)
        
        placeholderHiddenSubject
            .sink { [weak self] isHidden in
                guard let self else { return }
                self.placeholderLabel.isHidden = isHidden
            }
            .store(in: cancelBag)
    }
}
