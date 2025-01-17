//
//  HousePhotoCollectionViewCell.swift
//  Roomie
//
//  Created by 김승원 on 1/16/25.
//

import UIKit

import SnapKit
import Then

final class HousePhotoCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UIComponent
    
    private let photoImageView = UIImageView()
    
    private let roundedTopView = UIView()
    
    // MARK: - UISetting
    
    override func setStyle() {
        photoImageView.do {
            $0.backgroundColor = .grayscale4
        }
        
        roundedTopView.do {
            $0.backgroundColor = .grayscale1
            $0.roundCorners(cornerRadius: 16, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        }
    }
    
    override func setUI() {
        addSubview(photoImageView)
        photoImageView.addSubview(roundedTopView)
    }
    
    override func setLayout() {
        photoImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        roundedTopView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Screen.height(20))
        }
    }
}

// TODO: dataBind 함수 구현
