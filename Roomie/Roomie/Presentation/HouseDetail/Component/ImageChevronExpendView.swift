//
//  ImageChevronExpendView.swift
//  Roomie
//
//  Created by 김승원 on 1/22/25.
//

import UIKit
import Combine

import CombineCocoa
import SnapKit
import Then

final class ImageChevronExpendView: UIView {
    
    // MARK: - Property
    
    private var isExpended: Bool = false {
        didSet {
            updateView()
        }
    }
    
    private var unExpendedHeight: CGFloat = 56
    private var expendedHeight: CGFloat = 0
    
    private let cancelBag = CancelBag()
    
    // MARK: - UIComponent
    
    private let titleLabel = UILabel()
    
    private let statusBackView = UIView()
    private let statusLabel = UILabel()
    
    private let chevronIcon = UIImageView()
    
    private let expendButton = UIButton()
    
    private let roomImageView = UIImageView()
    
    private let evenStackView = UIStackView()
    private let oddStackView = UIStackView()
    
    // MARK: - Initializer
    
    init(title: String, status: Bool) {
        super.init(frame: .zero)
        
        setFacilityView(with: title, status: status)
        
        setStyle()
        setUI()
        setLayout()
        setAction()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setFacilityView()
        
        setStyle()
        setUI()
        setLayout()
        setAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setFacilityView()
        
        setStyle()
        setUI()
        setLayout()
        setAction()
    }
    
    // MARK: - UISetting
    
    private func setStyle() {
        self.do {
            $0.backgroundColor = .grayscale1
            $0.layer.borderColor = UIColor.grayscale5.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 8
        }
        
        statusBackView.do {
            $0.backgroundColor = .grayscale3
            $0.layer.cornerRadius = 8
            $0.clipsToBounds = true
        }
        
        statusLabel.do {
            $0.setText("입주 완료", style: .caption2, color: .grayscale9)
        }
        
        chevronIcon.do {
            $0.image = .icnArrowDownLine24
            $0.contentMode = .scaleAspectFit
        }
        
        roomImageView.do {
            $0.backgroundColor = .grayscale5
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 8
            $0.clipsToBounds = true
            $0.isHidden = true
        }
        
        evenStackView.do {
            $0.axis = .vertical
            $0.spacing = Screen.height(8)
            $0.alignment = .fill
            $0.distribution = .equalSpacing
            $0.isHidden = true
        }
        
        oddStackView.do {
            $0.axis = .vertical
            $0.spacing = Screen.height(8)
            $0.alignment = .fill
            $0.distribution = .equalSpacing
            $0.isHidden = true
        }
    }
    
    private func setUI() {
        addSubviews(
            titleLabel,
            statusBackView,
            chevronIcon,
            expendButton,
            roomImageView,
            evenStackView,
            oddStackView
        )
        
        statusBackView.addSubview(statusLabel)
    }
    
    private func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(Screen.height(56))
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Screen.height(18))
            $0.leading.equalToSuperview().offset(14)
        }
        
        statusBackView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8)
            $0.height.equalTo(Screen.height(20))
        }
        
        statusLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }
        
        chevronIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Screen.height(16))
            $0.trailing.equalToSuperview().inset(12)
            $0.size.equalTo(Screen.width(24))
        }
        
        expendButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Screen.height(56))
        }
        
        roomImageView.snp.makeConstraints {
            $0.top.equalTo(expendButton.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.height.equalTo(Screen.height(192))
        }
        
        evenStackView.snp.makeConstraints {
            $0.top.equalTo(roomImageView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(8)
            $0.width.equalTo(Screen.width(155))
        }
        
        oddStackView.snp.makeConstraints {
            $0.top.equalTo(roomImageView.snp.bottom).offset(12)
            $0.trailing.equalToSuperview().inset(8)
            $0.width.equalTo(Screen.width(155))
        }
    }
    
    private func setAction() {
        expendButton.tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.isExpended.toggle()
            }
            .store(in: cancelBag)
    }
}

// MARK: - Functions

private extension ImageChevronExpendView {
    private func updateView() {
        oddStackView.isHidden = !isExpended
        evenStackView.isHidden = !isExpended
        roomImageView.isHidden = !isExpended
        
        self.snp.updateConstraints {
            $0.height.equalTo(Screen.height(isExpended ? expendedHeight : unExpendedHeight))
        }
        
        chevronIcon.image = isExpended ? .icnArrowUpLine24 : .icnArrowDownLine24
        
        self.layoutIfNeeded()
    }
    
    private func setFacilityView(with title: String = "", status: Bool = true) {
        titleLabel.do {
            $0.setText(title, style: .body2, color: status ? .grayscale10 : .grayscale6)
        }
        statusBackView.isHidden = status
        statusLabel.isHidden = status
    }
}

extension ImageChevronExpendView {
    func dataBind(_ data: [String]) {
        let evenDataCount = (data.count + 1) / 2
        
        let itemHeight: CGFloat = 20
        let spacing: CGFloat = 8
        let stackViewHeight = CGFloat(evenDataCount) * itemHeight + CGFloat(evenDataCount - 1) * spacing
        self.expendedHeight = 192 + 12 + 56 + stackViewHeight + 12
        
        for index in 0..<data.count {
            if index % 2 == 0 {
                evenStackView.addArrangedSubview(CheckIconLabel(text: data[index]))
            } else {
                oddStackView.addArrangedSubview(CheckIconLabel(text: data[index]))
            }
        }
    }
    
    func setExpended(_ isExpended: Bool) {
        self.isExpended = isExpended
    }
}
