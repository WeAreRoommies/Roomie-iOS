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
    
    private func bindViewModel() {
        let input = MapViewModel.Input(
            viewWillAppear: viewWillAppearSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.markerInfo
            .sink { marker in
                for (x, y) in marker {
                    let marker = NMFMarker(position: NMGLatLng(lat: x, lng: y))
                    marker.mapView = self.rootView.mapView
                    marker.iconImage = NMFOverlayImage(name: "icn_map_pin_normal")
                    marker.width = 36
                    marker.height = 36
                }
            }
            .store(in: cancelBag)
    }
}
