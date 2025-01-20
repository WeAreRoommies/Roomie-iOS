//
//  RoommateNotFoundTableViewCell.swift
//  Roomie
//
//  Created by 김승원 on 1/21/25.
//

import UIKit

import SnapKit
import Then

final class RoommateNotFoundTableViewCell: BaseTableViewCell {
    
    // MARK: - UIComponent
    
    private let backView = UIView()
    
    private let titleLabel = UILabel()
    
    // MARK: - UISetting
    
    override func setStyle() {
        backView.do {
            $0.layer.borderColor = UIColor.grayscale5.cgColor
            $0.layer.cornerRadius = 8
            $0.layer.borderWidth = 1
            $0.clipsToBounds = true
        }
        
        titleLabel.do {
            $0.setText("아직 입주한 룸메이트가 없어요!", style: .body2, color: .grayscale8)
        }
    }
    
    override func setUI() {
        addSubview(backView)
        
        backView.addSubview(titleLabel)
    }
    
    override func setLayout() {
        backView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(12)
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
