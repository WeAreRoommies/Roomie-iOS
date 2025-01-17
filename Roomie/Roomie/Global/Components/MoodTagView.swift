//
//  MoodTagView.swift
//  Roomie
//
//  Created by 김승원 on 1/17/25.
//

import UIKit

import SnapKit
import Then

final class MoodTagView: UIView {
    
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

extension MoodTagView {
    func setMoodTagView(with roomMood: String = "") {
        let isMainMoodType = MoodType.allCases.contains(where: { $0.title == roomMood })
        backgroundColor = isMainMoodType ? .primaryLight4 : .grayscale3
        roomMoodHashTagLabel
            .setText(
                "#\(roomMood)",
                style: .body3,
                color: isMainMoodType ? .primaryPurple : .grayscale9
            )
    }
}
