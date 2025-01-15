//
//  MapSearchView.swift
//  Roomie
//
//  Created by 예삐 on 1/16/25.
//

import UIKit

import SnapKit
import Then

final class MapSearchView: BaseView {
    
    // MARK: - UIComponent
    
    let backButton = UIButton()
    
    let searchTextField = MapTextField("원하는 장소를 찾아보세요")
    private let searchImageView = UIImageView()
    private let seperatorView = UIView()
    
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 12
        }
    )
    
    // MARK: - UISetting
    
    override func setStyle() {
        backButton.do {
            $0.setImage(.btnBack, for: .normal)
        }
        
        searchTextField.do {
            $0.addPadding(left: 16, right: 46)
        }
        
        searchImageView.do {
            $0.image = .icnSearch40
        }
        
        seperatorView.do {
            $0.backgroundColor = .grayscale4
        }
        
        collectionView.do {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = true
            $0.showsHorizontalScrollIndicator = false
        }
    }
    
    override func setUI() {
        addSubviews(backButton, searchTextField, searchImageView, seperatorView, collectionView)
    }
    
    override func setLayout() {
        backButton.snp.makeConstraints {
            $0.centerY.equalTo(searchTextField.snp.centerY)
            $0.leading.equalToSuperview().inset(4)
            $0.size.equalTo(44)
        }
        
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(12)
            $0.leading.equalTo(backButton.snp.trailing).offset(2)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        searchImageView.snp.makeConstraints {
            $0.centerY.equalTo(searchTextField.snp.centerY)
            $0.trailing.equalTo(searchTextField.snp.trailing).offset(-8)
            $0.size.equalTo(40)
        }
        
        seperatorView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(seperatorView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
