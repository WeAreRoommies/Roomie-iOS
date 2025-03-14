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

final class ImageHorizontalScrollView: UIView {
    
    // MARK: - Property
    
    private var currentPage: Int = 1 {
        didSet {
            pageCountLabel.do {
                $0.updateText("\(currentPage)/\(totalPage)")
            }
        }
    }
    
    private var totalPage: Int = 1
    
    // MARK: - UIComponent
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    private let pageContainerView = UIView()
    private let pageCountLabel = UILabel()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDelegate() {
        scrollView.delegate = self
    }
    
    // MARK: - UISetting
    
    private func setStyle() {
        scrollView.do {
            $0.backgroundColor = .white
            $0.isPagingEnabled = true
            $0.showsHorizontalScrollIndicator = false
        }
        
        stackView.do {
            $0.axis = .horizontal
            $0.spacing = 0
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
        
        pageContainerView.do {
            $0.backgroundColor = .transpGray1250
            $0.layer.cornerRadius = 11
            $0.clipsToBounds = true
        }
    }
    
    private func setUI() {
        addSubviews(scrollView, pageContainerView)
        scrollView.addSubview(stackView)
        pageContainerView.addSubview(pageCountLabel)
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
        
        pageContainerView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.width.equalTo(Screen.width(35))
            $0.height.equalTo(Screen.height(22))
        }
        
        pageCountLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

// MARK: - Functions

extension ImageHorizontalScrollView {
    func setImages(urlStrings: [String]) {
        self.totalPage = urlStrings.count
        
        pageCountLabel.do {
            $0.setText("\(currentPage)/\(totalPage)", style: .caption3, color: .grayscale1)
        }
        
        for imageURL in urlStrings {
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

// MARK: - UIScrollViewDelegate

extension ImageHorizontalScrollView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        currentPage = index + 1
    }
}
