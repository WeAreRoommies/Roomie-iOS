//
//  RoomieIconButton.swift
//  Roomie
//
//  Created by 예삐 on 1/16/25.
//

import UIKit
import Combine

import CombineCocoa

/// grayscale1 색상의 아이콘 버튼 컴포넌트입니다.
///
/// 초기화 시 버튼 아이콘 이미지를 설정할 수 있습니다.
///
/// - Parameters:
///     - imageName: 버튼 아이콘을 나타내는 UIImage의 이름 String입니다.
final class RoomieIconButton: UIButton {
    
    // MARK: - Property
    
    static let defaultWidth: CGFloat = Screen.height(48)
    static let defaultHeight: CGFloat = Screen.height(50)
    
    private let cancelBag = CancelBag()
    
    // MARK: - Initializer
    
    init(imageName: String, border: Bool = false) {
        super.init(frame: .zero)
        
        setButton(with: imageName, border: border)
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

private extension RoomieIconButton {
    func setButton(with imageName: String = "", border: Bool = false) {
        guard let image = UIImage(named: imageName) else { return }
        setImage(image, for: .normal)
        
        if border {
            setLayer(borderWidth: 1, borderColor: .grayscale5, cornerRadius: 8)
        } else {
            setLayer(borderWidth: 1, borderColor: .grayscale4, cornerRadius: 8)
            
            self.backgroundColor = .grayscale1
            self.layer.shadowOpacity = 0.25
            self.layer.shadowRadius = 2
            self.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
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
}
