//
//  MapView.swift
//  Roomie
//
//  Created by 예삐 on 1/9/25.
//

import UIKit

import NMapsMap
import SnapKit
import Then

final class MapView: BaseView {
    
    // MARK: - UIComponent
    
    private let searchImageView = UIImageView()
    
    let searchTextField = UITextField()
    
    let filteringButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "icn_map_fillter_20")
        let button = UIButton(configuration: config)
        return button
    }()
    
    let mapView = NMFMapView(frame: .zero)
    
    let mapDetailCardView = MapDetialCardView()
    
    // MARK: - UISetting

    override func setStyle() {
        searchTextField.do {
            $0.addPadding(left: 16, right: 46)
            $0.setText(
                placeholder: "원하는 장소를 찾아보세요",
                placeholderColor: .grayscale7,
                textColor: .grayscale12,
                backgroundColor: .grayscale1,
                style: .title1
            )
            $0.layer.cornerRadius = 8
            $0.layer.shadowOpacity = 0.25
            $0.layer.shadowRadius = 2
            $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
        
        filteringButton.do {
            $0.backgroundColor = .grayscale1
            $0.layer.cornerRadius = 8
            $0.layer.shadowOpacity = 0.25
            $0.layer.shadowRadius = 2
            $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
        
        searchImageView.do {
            $0.image = .icnSearch40
        }
        
        mapView.do {
            $0.moveCamera(NMFCameraUpdate(scrollTo: NMGLatLng(lat: 37.555184166, lng: 126.936910322)))
        }
        
        mapDetailCardView.do {
            $0.backgroundColor = .grayscale1
            $0.layer.cornerRadius = 12
            $0.isHidden = true
            $0.layer.shadowOpacity = 0.25
            $0.layer.shadowRadius = 2
            $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
    
    override func setUI() {
        addSubviews(mapView, mapDetailCardView, searchTextField, filteringButton, searchImageView)
    }
    
    override func setLayout() {
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(12)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(filteringButton.snp.leading).offset(-8)
            $0.height.equalTo(50)
        }
        
        searchImageView.snp.makeConstraints {
            $0.centerY.equalTo(searchTextField.snp.centerY)
            $0.trailing.equalTo(searchTextField.snp.trailing).offset(-6)
            $0.size.equalTo(40)
        }
        
        filteringButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(12)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(48)
            $0.height.equalTo(50)
        }
        
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mapDetailCardView.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(170)
        }
    }
}
