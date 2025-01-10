//
//  MapViewController.swift
//  Roomie
//
//  Created by 예삐 on 1/9/25.
//

import UIKit
import Combine

import NMapsMap

final class MapViewController: BaseViewController {
    private let rootView = MapView()
    private let viewModel = MapViewModel()
    private let cancelBag = CancelBag()
    
    private let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    private let markerDidSelectSubject = PassthroughSubject<Int, Never>()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewWillAppearSubject.send(())
    }
    
    override func setupDelegate() {
        rootView.mapView.touchDelegate = self
    }
    
    private func bindViewModel() {
        let input = MapViewModel.Input(
            viewWillAppear: viewWillAppearSubject.eraseToAnyPublisher(),
            markerDidSelect: markerDidSelectSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.markersInfo
            .sink { [weak self] markersInfo in
                for markerInfo in markersInfo {
                    let marker = NMFMarker(position: NMGLatLng(lat: markerInfo.x, lng: markerInfo.y))
                    marker.mapView = self?.rootView.mapView
                    marker.iconImage = NMFOverlayImage(name: "icn_map_pin_normal")
                    marker.width = 36
                    marker.height = 36
                    
                    marker.touchHandler = { [weak self] _ in
                        self?.markerDidSelectSubject.send(markerInfo.houseID)
                        
                        return true
                    }
                }
            }
            .store(in: cancelBag)
        
        output.markerDetailInfo
            .sink { [weak self] markerDetailInfo in
                self?.rootView.mapDetailCardView.isHidden = false
                self?.rootView.mapDetailCardView.titleLabel.updateText(
                    "월세 \(markerDetailInfo.monthlyRent)"
                )
                self?.rootView.mapDetailCardView.depositLabel.updateText(
                    "보증금 \(markerDetailInfo.deposit)"
                )
                self?.rootView.mapDetailCardView.contractTermLabel.updateText(
                    "\(markerDetailInfo.contractTerm)개월"
                )
                self?.rootView.mapDetailCardView.genderOccupancyLabel.updateText(
                    "\(markerDetailInfo.genderPolicy)・\(markerDetailInfo.occupancyType)"
                )
                self?.rootView.mapDetailCardView.locationLabel.updateText(
                    "\(markerDetailInfo.location)・\(markerDetailInfo.locationDescription)"
                )
                self?.rootView.mapDetailCardView.moodTagLabel.updateText(markerDetailInfo.moodTag)
            }
            .store(in: cancelBag)
    }
}

extension MapViewController: NMFMapViewTouchDelegate {
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        if !rootView.mapDetailCardView.isHidden {
            rootView.mapDetailCardView.isHidden = true
        }
    }
}
