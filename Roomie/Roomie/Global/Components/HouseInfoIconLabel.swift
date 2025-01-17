//
//  HouseInfoIconLabel.swift
//  Roomie
//
//  Created by 김승원 on 1/17/25.
//

import UIKit

import SnapKit
import Then

enum HouseInfoType {
    case location
    case occupancyTypes
    case occupancyStatus
    case genderPolicy
    case contractTerm
    
    var icon: UIImage {
        switch self {
        case .location:
            return .icnDetailLocation20
        case .occupancyTypes:
            return .icnDetailRoom20
        case .occupancyStatus:
            return .icnDetailTotalpeople20
        case .genderPolicy:
            return .icnDetailGender20
        case .contractTerm:
            return .icnDetailCalendar20
        }
    }
}

final class HouseInfoIconLabel: UIView {
    
    // MARK: - UIComponent
    
    private let iconImageView = UIImageView()
    
    private let infoLabel = UILabel()
    
    // MARK: - Initializer
    
    init(_ text: String, houseInfoType: HouseInfoType) {
        super.init(frame: .zero)
        
        setIconLabel(with: text, houseInfoType: houseInfoType)
        
        setStyle()
        setUI()
        setLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setIconLabel()
        
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setIconLabel()
        
        setStyle()
        setUI()
        setLayout()
    }
    
    // MARK: - UISetting
    
    private func setStyle() {
        iconImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .grayscale10
        }
    }
    
    private func setUI() {
        addSubviews(iconImageView, infoLabel)
    }
    
    private func setLayout() {
        iconImageView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.equalTo(Screen.width(20))
        }
        
        infoLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalTo(iconImageView.snp.trailing).offset(4)
        }
    }
}

private extension HouseInfoIconLabel {
    func setIconLabel(with text: String = "", houseInfoType: HouseInfoType = .location) {
        infoLabel.setText(text, style: .body1, color: .grayscale10)
        iconImageView.image = houseInfoType.icon
    }
}

extension HouseInfoIconLabel {
    func updateText(with text: String) {
        infoLabel.updateText(text)
    }
}
