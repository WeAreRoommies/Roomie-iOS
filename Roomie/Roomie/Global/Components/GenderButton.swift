//
//  GenderButton.swift
//  Roomie
//
//  Created by 김승원 on 1/14/25.
//

import UIKit
import Combine

import CombineCocoa

final class GenderButton: UIButton {
    
    // MARK: - Property
    
    enum Gender {
        case male
        case female
        
        var genderString: String {
            switch self {
            case .male:
                return "남성"
            case .female:
                return "여성"
            }
        }
    }
    
    static let defaultWidth: CGFloat = Screen.width(162)
    static let defaultHeight: CGFloat = Screen.height(44)
    
    private let cancelBag = CancelBag()
    
    // MARK: - Initializer
    
    init(gender: Gender) {
        super.init(frame: .zero)
        
        setButton(with: gender)
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

private extension GenderButton {
    func setButton(with gender: Gender  = .male) {
        setTitle(gender.genderString, style: .body1, color: .grayscale12)
        setLayer(borderWidth: 1, borderColor: .grayscale5, cornerRadius: 8)
        isEnabled = true
    }
    
    func setButtonColor() {
        controlEventPublisher(for: .touchDown)
            .sink {
                self.backgroundColor = .primaryLight5
                self.layer.borderColor = UIColor.primaryPurple.cgColor
                self.setTitleColor(.primaryPurple, for: .normal)
            }
            .store(in: cancelBag)
        
//        Publishers.MergeMany(
//            controlEventPublisher(for: .touchUpInside),
//            controlEventPublisher(for: .touchUpOutside),
//            controlEventPublisher(for: .touchCancel)
//        )
//        .sink {
//            self.backgroundColor = .grayscale1
//            self.layer.borderColor = UIColor.grayscale5.cgColor
//            self.setTitleColor(.grayscale12, for: .normal)
//        }
//        .store(in: cancelBag)
    }
}
