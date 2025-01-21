//
//  RoomTourButton.swift
//  Roomie
//
//  Created by 김승원 on 1/21/25.
//

import UIKit
import Combine

import CombineCocoa
import SnapKit
import Then

final class RoomTourButton: UIView {
    
    // MARK: - Property
    
    static let defaultWidth: CGFloat = Screen.width(162)
    static let defaultHeight: CGFloat = Screen.height(60)
    
    private var isTourAvailable: Bool = false
    
    var isSelected: Bool = false {
        didSet {
            updateColor()
        }
    }
    
    private let cancelBag = CancelBag()
    
    // MARK: - UIComponent
    
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let stackView = UIStackView()
    let roomButton = UIButton()
    
    // MARK: - Initializer
    
    init(name title: String, deposit subTitle: String, isTourAvailable: Bool) {
        self.isTourAvailable = isTourAvailable
        
        super.init(frame: .zero)
        
        setRoomTourButton(title: title, subTitle: subTitle)
        
        setStyle()
        setUI()
        setLayout()
        setAction()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setRoomTourButton()
        
        setStyle()
        setUI()
        setLayout()
        setAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setRoomTourButton()
        
        setStyle()
        setUI()
        setLayout()
        setAction()
    }
    
    // MARK: - UISetting
    
    private func setStyle() {
        self.do {
            $0.layer.cornerRadius = 8
            $0.layer.borderColor = UIColor.grayscale6.cgColor
            $0.layer.borderWidth = 1
        }
        
        stackView.do {
            $0.axis = .vertical
            $0.spacing = 4
            $0.alignment = .center
            $0.distribution = .fill
        }
    }
    
    private func setUI() {
        addSubviews(stackView, roomButton)
        
        stackView.addArrangedSubviews(titleLabel, subTitleLabel)
    }
    
    private func setLayout() {
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        roomButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - Functions

private extension RoomTourButton {
    func setRoomTourButton(title: String = "", subTitle: String = "") {
        roomButton.isEnabled = isTourAvailable
        backgroundColor = isTourAvailable ? .grayscale1 : .grayscale4
        titleLabel.setText("룸\(title)", style: .title2, color: isTourAvailable ? .grayscale12 : .grayscale7)
        subTitleLabel.setText(subTitle, style: .body4, color: .grayscale7)
    }
    
    func setAction() {
        roomButton.tapPublisher
            .sink {
                self.isSelected = true
            }
            .store(in: cancelBag)
    }
    
    func updateColor() {
        if isTourAvailable {
            backgroundColor = isSelected ? .primaryLight4 : .grayscale1
            layer.borderColor = isSelected ? UIColor.primaryPurple.cgColor : UIColor.grayscale6.cgColor
        } else {
            backgroundColor = .grayscale4
        }
    }
}

extension RoomTourButton {
    func updateSubTitleLabel(with text: String) {
        subTitleLabel.updateText(text)
    }
}
