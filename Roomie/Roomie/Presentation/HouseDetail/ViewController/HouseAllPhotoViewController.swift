//
//  HouseAllPhotoViewController.swift
//  Roomie
//
//  Created by 김승원 on 1/22/25.
//

import UIKit

final class HouseAllPhotoViewController: BaseViewController {
    
    // MARK: - Property
    
    private let rootView = HouseAllPhotoView()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        rootView.fetchRooms(RoomDetail.mockData())
    }
    
    override func setView() {
        setNavigationBar(with: "43~50/90~100", isBorderHidden: false)
    }
}
