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

final class UpdateButtonView: UIView {
    
    // MARK: - Property
    
    private var cancelBag = CancelBag()
    
    var isSelected: Bool = false
    
    // MARK: - UIComponents
    
    let titleLabel = UILabel()
    private let nextImageView = UIImageView()
    private let updateButton = UIButton()
    
    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
        setAction()
    }
    
    required init?(coder: NSCoder) {
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
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
        }
        
        nextImageView.snp.makeConstraints{
            $0.size.equalTo(CGSize(width: 20, height: 20))
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(24)
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

