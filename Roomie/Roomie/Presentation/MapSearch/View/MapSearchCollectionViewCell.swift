//
//  MapSearchCollectionViewCell.swift
//  Roomie
//
//  Created by 예삐 on 1/16/25.
//

import UIKit

import SnapKit
import Then

final class MapSearchCollectionViewCell: BaseCollectionViewCell {
        
    // MARK: - UIComponent
    
    private let cellView = UIView()
    
    private let titleLabel = UILabel()
    
    private let roadAdressTitleView = UIView()
    private let roadAdressTitleLabel = UILabel()
    private let roadAdressLabel = UILabel()
    
    private let lotAdressTitleView = UIView()
    private let lotAdressTitleLabel = UILabel()
    private let lotAdressLabel = UILabel()
    
    // MARK: - UISetting

    override func setStyle() {
        cellView.do {
            $0.backgroundColor = .grayscale1
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.grayscale5.cgColor
            $0.layer.cornerRadius = 8
        }
        
        titleLabel.do {
            $0.setText(style: .title2, color: .grayscale12)
        }
        
        roadAdressTitleView.do {
            $0.backgroundColor = .grayscale3
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.grayscale5.cgColor
            $0.layer.cornerRadius = 4
        }
        
        roadAdressTitleLabel.do {
            $0.setText("도로명", style: .caption2, color: .grayscale7)
        }
        
        roadAdressLabel.do {
            $0.setText(style: .body4, color: .grayscale9)
        }
        
        lotAdressTitleView.do {
            $0.backgroundColor = .grayscale3
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.grayscale5.cgColor
            $0.layer.cornerRadius = 4
        }
        
        lotAdressTitleLabel.do {
            $0.setText("지번", style: .caption2, color: .grayscale7)
        }
        
        lotAdressLabel.do {
            $0.setText(style: .body4, color: .grayscale9)
        }
    }
    
    override func setUI() {
        addSubview(cellView)
        cellView.addSubviews(
            titleLabel,
            roadAdressTitleView,
            roadAdressTitleLabel,
            roadAdressLabel,
            lotAdressTitleView,
            lotAdressTitleLabel,
            lotAdressLabel
        )
    }
    
    override func setLayout() {
        cellView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }
        
        roadAdressTitleView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(38)
            $0.height.equalTo(22)
        }
        
        roadAdressTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(roadAdressTitleView.snp.centerY)
            $0.centerX.equalTo(roadAdressTitleView.snp.centerX)
        }
        
        roadAdressLabel.snp.makeConstraints {
            $0.centerY.equalTo(roadAdressTitleView.snp.centerY)
            $0.leading.equalTo(roadAdressTitleView.snp.trailing).offset(8)
        }
        
        lotAdressTitleView.snp.makeConstraints {
            $0.top.equalTo(roadAdressTitleView.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(38)
            $0.height.equalTo(22)
        }
        
        lotAdressTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(lotAdressTitleView.snp.centerY)
            $0.centerX.equalTo(lotAdressTitleView.snp.centerX)
        }
        
        lotAdressLabel.snp.makeConstraints {
            $0.centerY.equalTo(lotAdressTitleView.snp.centerY)
            $0.leading.equalTo(lotAdressTitleView.snp.trailing).offset(8)
        }
    }
}

// MARK: - DataBind

extension MapSearchCollectionViewCell {
    func dataBind(_ data: MapSearchModel) {
        titleLabel.updateText(data.location)
        roadAdressLabel.updateText(data.roadAddress)
        lotAdressLabel.updateText(data.address)
    }
}
