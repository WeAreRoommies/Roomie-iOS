//
//  ImageHorizontalScrollView.swift
//  Roomie
//
//  Created by 김승원 on 3/13/25.
//

import UIKit
import Combine

import CombineCocoa
import Kingfisher
import SnapKit
import Then

class ImageHorizontalScrollView: UIView {
    
    // MARK: - UIComponent
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UISetting
    
    private func setStyle() {
        scrollView.do {
            $0.backgroundColor = .grayscale5
            $0.isPagingEnabled = true
            $0.showsHorizontalScrollIndicator = false
        }
        
        stackView.do {
            $0.axis = .horizontal
            $0.spacing = 0
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
        
    }
    
    private func setUI() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
    }
    
    private func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.greaterThanOrEqualToSuperview().priority(.low)
        }
    }
}

extension ImageHorizontalScrollView {
    func setImages(imageURLs: [String]) {
        for imageURL in imageURLs {
            if let imageURL = URL(string: imageURL) {
                let imageView = UIImageView()
                
                imageView.do {
                    $0.kf.setImage(with: imageURL)
                    $0.contentMode = .scaleAspectFill
                    $0.clipsToBounds = true
                    stackView.addArrangedSubview($0)
                }
                
                imageView.snp.makeConstraints {
                    $0.width.equalTo(scrollView.snp.width)
                }
            }
        }
    }
}
