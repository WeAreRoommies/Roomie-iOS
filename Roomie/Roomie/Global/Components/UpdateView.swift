//
//  UpdateView.swift
//  Roomie
//
//  Created by MaengKim on 1/14/25.
//
import UIKit
import Combine

import CombineCocoa
import Then
import SnapKit

final class UpdateView: UIView {
    
    // MARK: - Property
    
    private var cancelBag = CancelBag()
    
    var isSelected: Bool
    
    
    // MARK: - UIComponents
    
    let titleLabel = UILabel()
    private let nextImageView = UIImageView()
    private let updateButton = UIButton()
    
    // MARK: - Initializer

    override init(frame: CGRect) {
        self.isSelected = false
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
        setAction()
    }
    
    required init?(coder: NSCoder) {
        self.isSelected = false
        super.init(coder: coder)
        
        setStyle()
        setUI()
        setLayout()
        setAction()
    }
    
    // MARK: - UISetting

    private func setStyle() {
        self.backgroundColor = .grayscale1
        self.layer.cornerRadius = 8
        
        titleLabel.do {
            $0.setText("1월 1일 루미 업데이트 알아보기" ,style: .body2, color: .grayscale10)
        }
        
        nextImageView.do {
            $0.image = .icnArrowRightLine24
        }
    }
    
    private func setUI() {
        addSubviews(
            titleLabel,
            updateButton,
            nextImageView
        )
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(24)
        }
        
        nextImageView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(24)
            $0.width.height.equalTo(20)
        }
        
        updateButton.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Functions
    
    private func setAction() {
        updateButton
            .tapPublisher
            .sink { [weak self] in
                self?.isSelected.toggle()
            }
            .store(in: cancelBag)
    }
}

