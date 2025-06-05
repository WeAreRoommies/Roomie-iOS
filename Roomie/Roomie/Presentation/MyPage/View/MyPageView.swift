//
//  MyPageView.swift
//  Roomie
//
//  Created by 예삐 on 1/9/25.
//

import UIKit

import SnapKit
import Then

final class MyPageView: BaseView {
    
    // MARK: - UIComponent
    
    let myPageHeaderButton = MyPageHeaderButton()
    
    private let plusLabel = UILabel()
    private let plusStackView = UIStackView()
    let wishListButton = MyPageCellButton(title: "찜리스트")
    private let searchHouseButton = MyPageCellButton(
        title: "쉐어하우스 찾기",
        subtitle: "원하는 매물이 없다면 새로 요청해보세요"
    )
    private let registerHouseButton = MyPageCellButton(
        title: "매물 등록하기",
        subtitle: "쉐어하우스 사장님이라면 매물을 등록해보세요"
    )
    private let sendFeedbackButton = MyPageCellButton(title: "의견 보내기")
    
    private let seperatorView = UIView()
    
    private let serviceLabel = UILabel()
    private let serviceStackView = UIStackView()
    private let introduceServiceButton = MyPageCellButton(title: "서비스 소개")
    private let latestNewsButton = MyPageCellButton(title: "최근 소식")
    private let policyButton = MyPageCellButton(title: "약관 및 소개")
    
    // MARK: - UISetting
    
    override func setStyle() {
        plusLabel.do {
            $0.setText("루미 더보기", style: .body1, color: .grayscale7)
        }
        
        plusStackView.do {
            $0.axis = .vertical
            $0.spacing = 0
        }
        
        seperatorView.do {
            $0.backgroundColor = .grayscale4
        }
        
        serviceStackView.do {
            $0.axis = .vertical
            $0.spacing = 0
        }
        
        serviceLabel.do {
            $0.setText("루미 서비스 정보", style: .body1, color: .grayscale7)
        }
    }
    
    override func setUI() {
        addSubviews(
            myPageHeaderButton,
            plusLabel,
            plusStackView,
            seperatorView,
            serviceLabel,
            serviceStackView
        )
        plusStackView.addArrangedSubviews(
            wishListButton,
            searchHouseButton,
            registerHouseButton,
            sendFeedbackButton
        )
        serviceStackView.addArrangedSubviews(
            introduceServiceButton,
            latestNewsButton,
            policyButton
        )
    }
    
    override func setLayout() {
        myPageHeaderButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Screen.height(120))
        }
        
        plusLabel.snp.makeConstraints {
            $0.top.equalTo(myPageHeaderButton.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(20)
        }
        
        plusStackView.snp.makeConstraints {
            $0.top.equalTo(plusLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
        }
        
        seperatorView.snp.makeConstraints {
            $0.top.equalTo(plusStackView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20).priority(.high)
            $0.height.equalTo(1)
        }
        
        serviceLabel.snp.makeConstraints {
            $0.top.equalTo(seperatorView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(20)
        }
        
        serviceStackView.snp.makeConstraints {
            $0.top.equalTo(serviceLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
