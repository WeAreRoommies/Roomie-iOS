//
//  MapViewController.swift
//  Roomie
//
//  Created by 예삐 on 1/9/25.
//

import UIKit
import Combine

import CombineCocoa
import NMapsMap

final class MapViewController: BaseViewController {
    
    // MARK: - Property

    private let rootView = MapView()
    
    private let viewModel: MapViewModel
    
    private let cancelBag = CancelBag()
    
    private var markers: [NMFMarker] = []
    private var selectedMarker: NMFMarker?
    
    private let viewWillAppearSubject = CurrentValueSubject<Void, Never>(())
    private let markerDidSelectSubject = PassthroughSubject<Int, Never>()
    private let eraseButtonDidTapSubject = PassthroughSubject<Void, Never>()
    
    // MARK: - Initializer

    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle

    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        viewWillAppearSubject.send(())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Functions
    
    override func setDelegate() {
        rootView.mapView.touchDelegate = self
    }
    
    override func setAction() {
        rootView.searchBarButton
            .tapPublisher
            .sink {
                let mapSearchViewController = MapSearchViewController(
                    viewModel: MapSearchViewModel(
                        service: MapsService(),
                        builder: MapRequestDTO.Builder.shared
                    )
                )
                mapSearchViewController.delegate = self
                self.navigationController?.pushViewController(mapSearchViewController, animated: true)
            }
            .store(in: cancelBag)
        
        rootView.filteringButton
            .tapPublisher
            .sink {
                let mapFilterViewController = MapFilterViewController(
                    viewModel: MapFilterViewModel(builder: MapRequestDTO.Builder.shared)
                )
                mapFilterViewController.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(mapFilterViewController, animated: true)
            }
            .store(in: cancelBag)
        
        rootView.mapListButton
            .tapPublisher
            .sink { [weak self] in
                self?.presentMapListSheetSheet()
            }
            .store(in: cancelBag)
        
        rootView.eraseButton
            .tapPublisher
            .sink { [weak self] in
                self?.eraseButtonDidTapSubject.send()
                self?.rootView.searchBarLabel.setText("원하는 장소를 찾아보세요", style: .title1, color: .grayscale7)
                self?.rootView.eraseButton.isHidden = true
                self?.rootView.searchImageView.isHidden = false
            }
            .store(in: cancelBag)
        
        rootView.mapDetailCardView.arrowButton
            .tapPublisher
            .sink {
                // TODO: 매물 상세 뷰 화면 연결
            }
            .store(in: cancelBag)
    }
}

private extension MapViewController {
    func bindViewModel() {
        let input = MapViewModel.Input(
            viewWillAppear: viewWillAppearSubject.eraseToAnyPublisher(),
            markerDidSelect: markerDidSelectSubject.eraseToAnyPublisher(),
            eraseButtonDidTap: eraseButtonDidTapSubject.eraseToAnyPublisher(),
            pinnedHouseID: PassthroughSubject<Int, Never>().eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        
        output.markersInfo
            .receive(on: RunLoop.main)
            .sink { [weak self] markersInfo in
                guard let self = self else { return }
                
                removeAllMarkers()
                
                for markerInfo in markersInfo {
                    let marker = NMFMarker(position: NMGLatLng(lat: markerInfo.x, lng: markerInfo.y))
                    marker.mapView = self.rootView.mapView
                    marker.iconImage = NMFOverlayImage(name: "icn_map_pin_normal")
                    marker.width = 36
                    marker.height = 40
                    
                    marker.touchHandler = { [weak self] _ in
                        guard let self = self else { return false }
                        
                        erasePreviousSelectedMarker()
                        marker.iconImage = NMFOverlayImage(name: "icn_map_pin_active")
                        self.selectedMarker = marker
                        
                        let cameraUpdate = NMFCameraUpdate(
                            scrollTo: NMGLatLng(lat: markerInfo.x, lng: markerInfo.y),
                            zoomTo: 13
                        )
                        cameraUpdate.animation = .easeIn
                        rootView.mapView.moveCamera(cameraUpdate)
                        
                        self.markerDidSelectSubject.send(markerInfo.houseID)
                        
                        return true
                    }
                    
                    self.markers.append(marker)
                }
            }
            .store(in: cancelBag)
        
        output.markerDetailInfo
            .receive(on: RunLoop.main)
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
                self?.rootView.mapDetailCardView.moodTagLabel.updateText(
                    markerDetailInfo.moodTag
                )
            }
            .store(in: cancelBag)
        
        output.defaultLocationInfo
            .receive(on: RunLoop.main)
            .sink { [weak self] (lat, lng) in
                guard let self = self else { return }
                let cameraUpdate = NMFCameraUpdate(
                    scrollTo: NMGLatLng(lat: lat, lng: lng),
                    zoomTo: 12
                )
                cameraUpdate.animation = .easeIn
                self.rootView.mapView.moveCamera(cameraUpdate)
            }
            .store(in: cancelBag)
    }
    
    func removeAllMarkers() {
        for marker in markers {
            marker.mapView = nil
        }
        markers.removeAll()
    }
    
    func erasePreviousSelectedMarker() {
        if let previousMarker = self.selectedMarker {
            previousMarker.iconImage = NMFOverlayImage(name: "icn_map_pin_normal")
        }
    }
}

// MARK: - MapSearchViewControllerDelegate

extension MapViewController: MapSearchViewControllerDelegate {
    func didSelectLocation(location: String, lat: Double, lng: Double) {
        
        rootView.searchBarLabel.setText(location, style: .title1, color: .grayscale12)
        rootView.searchImageView.isHidden = true
        rootView.eraseButton.isHidden = false
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng))
        cameraUpdate.animation = .easeIn
        rootView.mapView.moveCamera(cameraUpdate)
    }
}

// MARK: - NMFMapViewTouchDelegate

extension MapViewController: NMFMapViewTouchDelegate {
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        if !rootView.mapDetailCardView.isHidden {
            erasePreviousSelectedMarker()
            
            let cameraUpdate = NMFCameraUpdate(
                zoomTo: 12
            )
            cameraUpdate.animation = .easeIn
            rootView.mapView.moveCamera(cameraUpdate)
            
            rootView.mapDetailCardView.isHidden = true
        }
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate

extension MapViewController: UIAdaptivePresentationControllerDelegate {
    func presentMapListSheetSheet() {
        let mapListSheetViewController = MapListSheetViewController(
            viewModel: MapViewModel(service: MapsService(), builder: MapRequestDTO.Builder.shared)
        )
        
        mapListSheetViewController.delegate = self
        
        let mediumDetent = UISheetPresentationController.Detent.custom { _ in 348 }
        let largeDetent = UISheetPresentationController.Detent.custom { _ in 648 }
        
        if let sheet = mapListSheetViewController.sheetPresentationController {
            sheet.detents = [mediumDetent, largeDetent]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 16
        }
        mapListSheetViewController.isModalInPresentation = false
        
        self.present(mapListSheetViewController, animated: true)
    }
}

extension MapViewController: MapListSheetViewControllerDelegate {
    func houseCellDidTap(houseID: Int) {
        let houseDetailViewController = HouseDetailViewController(
            viewModel: HouseDetailViewModel(houseID: houseID, service: HousesService())
        )
        houseDetailViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(houseDetailViewController, animated: true)
    }
}
