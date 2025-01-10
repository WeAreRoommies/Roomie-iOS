//
//  MapView.swift
//  Roomie
//
//  Created by 예삐 on 1/9/25.
//

import UIKit

import SnapKit
import Then
import NMapsMap

final class MapView: BaseView {
    
    // MARK: - UIComponent

    let mapView = NMFMapView(frame: .zero)
    
    let mapDetailCardView = MapDetialCardView()
    
    // MARK: - UISetting

    override func setStyle() {
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
        addSubviews(mapView, mapDetailCardView)
    }
    
    override func setLayout() {
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
