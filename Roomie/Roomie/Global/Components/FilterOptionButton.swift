//
//  FilterOptionButton.swift
//  Roomie
//
//  Created by 예삐 on 1/14/25.
//

import UIKit
import Combine

import CombineCocoa
import SnapKit
import Then

final class FilterOptionButton: UIView {
    
    // MARK: - Property

    private let cancelBag = CancelBag()
    
    var isSelected: Bool {
        didSet {
            updateButtonColor()
        }
    }
    
    // MARK: - UIComponents

    private let titleLabel = UILabel()
    private let optionButton = UIButton()
    
    // MARK: - Initializer
    
    init(title: String, isSelected: Bool = false) {
        self.isSelected = isSelected
        super.init(frame: .zero)
        
        setStyle()
        setUI()
        setLayout()
        setAction()
        
        titleLabel.text = title
    }
    
    override init(frame: CGRect) {
        self.isSelected = false
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
        setAction()
    }
    
    required init?(coder: NSCoder) {
        self.isSelected = false
        super.init(coder: coder)
        
        setStyle()
        setUI()
        setLayout()
        setAction()
    }
    
    // MARK: - UISetting
    
    private func setStyle() {
        self.do {
            $0.layer.borderColor = UIColor.grayscale5.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 4
        }
        
        titleLabel.do {
            $0.font = .pretendard(.body1)
        }
    }
    
    private func setUI() {
        addSubviews(titleLabel, optionButton)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
        
        optionButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Functions
    
    private func setAction() {
        optionButton
            .tapPublisher
            .sink { [weak self] in
                self?.isSelected.toggle()
            }
            .store(in: cancelBag)
    }
    
    private func updateButtonColor() {
        titleLabel.textColor = isSelected ? .primaryPurple : .grayscale11
        backgroundColor = isSelected ? .primaryLight5 : .grayscale1
        layer.borderColor = isSelected ? UIColor.primaryPurple.cgColor : UIColor.grayscale5.cgColor
    }
}
