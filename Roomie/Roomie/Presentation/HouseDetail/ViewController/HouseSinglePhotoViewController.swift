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
    
    private var expandedIndex: Int
    
    // MARK: - Initializer
    
    init(index: Int) {
        expandedIndex = index
        
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        rootView.fetchRooms(RoomDetail.mockData(), with: expandedIndex)
    }
    
    override func setView() {
        setNavigationBar(with: "43~50/90~100")
        
    }
}
