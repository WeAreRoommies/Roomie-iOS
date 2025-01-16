//
//  MoodListViewController.swift
//  Roomie
//
//  Created by MaengKim on 1/16/25.
//

import UIKit

import SnapKit
import Then

final class MoodListViewController: BaseViewController {
    
    // MARK: - Property
    
    private let rootView = MoodListView()
    
    private let viewModel: MoodListViewModel
    
    final let cellHeight: CGFloat = 112
    final let cellWidth: CGFloat = UIScreen.main.bounds.width - 32
    final let contentInterSpacing: CGFloat = 4
    final let contentInset = UIEdgeInsets(top: 12, left: 16, bottom: 24, right: 16)
    
    private var moodListRooms: [MoodListRoom] = MoodListRoom.moodListRoomData()
    
    // MARK: - Initializer
    
    init(viewModel: MoodListViewModel) {
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
    }
    
    // MARK: - Functions
    
    override func setView() {
        setNavigationBar(with: "dd")
    }
    
    override func setDelegate() {
        
    }
    
    private func setRegister() {
        
    }
    
}
