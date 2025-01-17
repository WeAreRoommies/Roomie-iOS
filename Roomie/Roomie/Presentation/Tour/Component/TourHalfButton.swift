//
//  TourHalfButton.swift
//  Roomie
//
//  Created by 김승원 on 1/14/25.
//

import UIKit
import Combine

import CombineCocoa

final class TourHalfButton: UIButton {
    
    // MARK: - Property
    
    static let defaultWidth: CGFloat = Screen.width(162)
    static let defaultHeight: CGFloat = Screen.height(44)
    
    override var isSelected: Bool {
        didSet {
            updateButtonColor()
        }
    }
    
    private let cancelBag = CancelBag()
    
    // MARK: - Initializer
    
    init(gender: Gender) {
        super.init(frame: .zero)
        
        setButton(with: gender)
        setAction()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setButton()
        setAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setButton()
        setAction()
    }
}

private extension TourHalfButton {
    func setButton(with gender: Gender  = .male) {
        setTitle(gender.genderString, style: .body1, color: .grayscale12)
        setLayer(borderWidth: 1, borderColor: .grayscale5, cornerRadius: 8)
        isEnabled = true
    }
    
    func setAction() {
        tapPublisher
            .sink {
                self.isSelected.toggle()
            }
            .store(in: cancelBag)
    }
    
    func updateButtonColor() {
        backgroundColor = isSelected ? .primaryLight5 : .grayscale1
        layer.borderColor = isSelected ? UIColor.primaryPurple.cgColor : UIColor.grayscale5.cgColor
        setTitleColor(isSelected ? .primaryPurple : .grayscale12, for: .normal)
    }
}
