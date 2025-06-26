//
//  MyAccountButton.swift
//  Roomie
//
//  Created by 예삐 on 6/10/25.
//

import UIKit
import Combine

import CombineCocoa

final class MyAccountWhiteButton: UIButton {
    
    // MARK: - Property
    
    static let defaultHeight: CGFloat = Screen.height(44)
    
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

private extension MyAccountWhiteButton {
    func setButton(with title: String = " ", isEnabled: Bool = true) {
        setTitle(title, style: .body2, color: isEnabled ? .primaryPurple : .grayscale7)
        setLayer(borderWidth: 1, borderColor: isEnabled ? .primaryPurple : .grayscale5, cornerRadius: 8)
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
    
    func updateButtonColor() {
        setTitleColor(isEnabled ? .primaryPurple : .grayscale7, for: .normal)
        layer.borderColor = isEnabled ? UIColor.primaryPurple.cgColor : UIColor.grayscale5.cgColor
    }
}
