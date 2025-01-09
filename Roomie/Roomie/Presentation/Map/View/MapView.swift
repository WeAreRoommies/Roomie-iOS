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
    let mapView = NMFMapView(frame: .zero)
    
    override func setStyle() {
        mapView.do {
            $0.moveCamera(NMFCameraUpdate(scrollTo: NMGLatLng(lat: 37.555184166, lng: 126.936910322)))
        }
    }
    
    override func setUI() {
        addSubview(mapView)
    }
    
    override func setLayout() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
