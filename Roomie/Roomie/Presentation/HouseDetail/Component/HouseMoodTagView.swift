//
//  HouseMoodTagView.swift
//  Roomie
//
//  Created by 김승원 on 1/17/25.
//

import UIKit

import SnapKit
import Then

final class HouseMoodTagView: UIView {
    
    // MARK: - UIComponent
    
    private let roomMoodHashTagLabel = UILabel()
    
    // MARK: - Initializer
    
    init(roomMood: String) {
        super.init(frame: .zero)
        
        setMoodTagView(with: roomMood)
        
        setStyle()
        setUI()
        setLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setMoodTagView()
        
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setMoodTagView()
        
        setStyle()
        setUI()
        setLayout()
    }
    
    // MARK: - UISetting
    
    private func setStyle() {
        self.do {
            $0.layer.cornerRadius = 4
            $0.backgroundColor = .primaryLight4
        }
    }
    
    private func setUI() {
        addSubview(roomMoodHashTagLabel)
    }
    
    private func setLayout() {
        roomMoodHashTagLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(4)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
    }
}

// MARK: - Functions

extension HouseMoodTagView {
    func setMoodTagView(with roomMood: String = "") {
        roomMoodHashTagLabel
            .setText(roomMood, style: .body3, color: .primaryPurple)
    }
}
