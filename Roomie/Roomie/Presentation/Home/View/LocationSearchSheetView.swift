//
//  LocationSearchSheetView.swift
//  Roomie
//
//  Created by MaengKim on 5/26/25.
//

import UIKit

import SnapKit
import Then

final class LocationSearchSheetView: BaseView {
    
    // MARK: - UIComponent
    
    private let indicatorView = UIView()
    let searchTextField = MapSearchTextField("원하는 장소를 찾아보세요")
    private let searchImageView = UIImageView()
    private let seperatorView = UIView()
    
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 12
        }
    )
    
    let emptyView = LocationSearchSheetEmptyView()
    
    // MARK: - UISetting
    
    override func setStyle() {
        indicatorView.do {
            $0.backgroundColor = .grayscale5
            $0.layer.cornerRadius = Screen.height(3)
        }
        
        searchImageView.do {
            $0.image = .icnSearch40
        }
        
        seperatorView.do {
            $0.backgroundColor = .grayscale4
        }
        
        collectionView.do {
            backgroundColor = .clear
            $0.showsVerticalScrollIndicator = true
            $0.showsHorizontalScrollIndicator = false
        }
        
        emptyView.do {
            $0.isHidden = true
        }
    }
    
    override func setUI() {
        addSubviews(
            indicatorView,
            searchTextField,
            searchImageView,
            seperatorView,
            emptyView,
            collectionView
        )
    }
    
    override func setLayout() {
        indicatorView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Screen.width(40))
            $0.height.equalTo(Screen.height(6))
        }
        
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(indicatorView.snp.bottom).offset(14)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(Screen.height(50))
        }
        
        searchImageView.snp.makeConstraints {
            $0.centerY.equalTo(searchTextField.snp.centerY)
            $0.trailing.equalTo(searchTextField.snp.trailing).offset(-8)
            $0.size.equalTo(40)
        }
        
        seperatorView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(seperatorView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints {
            $0.top.equalTo(seperatorView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
