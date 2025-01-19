//
//  RoomStatusView.swift
//  Roomie
//
//  Created by 김승원 on 1/19/25.
//

import UIKit

import SnapKit
import Then

final class RoomStatusView: UIView {
    
    // MARK: - UIComponent
    
    private let statusLabel = UILabel()
    
    // TODO: 추후 cell의 dataBind 함수에서 부르면 알아서 style 업데이트
    /// 입주상태를 나타내는 bool값입니다.
    var isAvailable: Bool = true {
        didSet {
            updateStatusStyle()
        }
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setStyle()
        setUI()
        setLayout()
    }
    
    // MARK: - UISetting
    
    private func setStyle() {
        self.do {
            $0.backgroundColor = .primaryLight4
            $0.layer.cornerRadius = 4
            $0.clipsToBounds = true
        }
        
        statusLabel.do {
            $0.setText("입주가능", style: .body4, color: .primaryPurple)
        }
    }
    
    private func setUI() {
        addSubview(statusLabel)
    }
    
    private func setLayout() {
        statusLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(4)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
    }
}

private extension RoomStatusView {
    func updateStatusStyle() {
        self.do {
            $0.backgroundColor = isAvailable ? .primaryLight4 : .grayscale3
        }
        
        statusLabel.do {
            $0.updateText(isAvailable ? "입주가능" : "입주불가")
            $0.textColor = isAvailable ? .primaryPurple : .grayscale9
        }
    }
}
