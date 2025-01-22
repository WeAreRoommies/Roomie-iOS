//
//  HouseSinglePhotoViewController.swift
//  Roomie
//
//  Created by 김승원 on 1/22/25.
//

import UIKit

final class HouseSinglePhotoViewController: BaseViewController {
    
    // MARK: - Property
    
    private let rootView = HouseSinglePhotoView()
    
    // MARK: - Initializer
    
    init(index: Int) {
        super.init(nibName: nil, bundle: nil)
        
        rootView.fetchRooms(RoomDetail.mockData(), with: index)
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
        
    }
    
    override func setView() {
        setNavigationBar(with: "43~50/90~100")
        
    }
}
