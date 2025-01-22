//
//  HouseDetailView.swift
//  Roomie
//
//  Created by 김승원 on 1/16/25.
//

import UIKit

import SnapKit
import Then

final class HouseDetailView: BaseView {
    
    // MARK: - UIComponent
    
    let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // HousePhoto Section
    let photoImageView = UIImageView()
    private let roundedTopView = UIView()
    
    // HouseInfo Section
    private let nameBackView = UIView()
    let nameLabel = UILabel()
    let titleLabel = UILabel()
    let locationIconLabel = HouseInfoIconLabel("서대문구 연희동", houseInfoType: .location)
    let occupancyTypesIconLabel = HouseInfoIconLabel("1,2인실", houseInfoType: .occupancyTypes)
    let occupancyStatusIconLabel = HouseInfoIconLabel("2/4인", houseInfoType: .occupancyStatus)
    let genderPolicyIconLabel = HouseInfoIconLabel("여성전용", houseInfoType: .genderPolicy)
    let contractTermIconLabel = HouseInfoIconLabel("3개월 이상 계약", houseInfoType: .contractTerm)
    private let firstIconLabelStackView = UIStackView()
    private let secondIconLabelStackView = UIStackView()
    let lookInsidePhotoButton = HouseInnerPhotoButton()
    private let houseInfoSeparatorView = UIView()
    
    // roomMood Section
    private let roomMoodTitleLabel = UILabel()
    private let roomMoodBackView = UIView()
    let roomMoodLabel = UILabel()
    let firstMoodTag = HouseMoodTagView(roomMood: "차분한")
    let secondMoodTag = HouseMoodTagView(roomMood: "조용한")
    let thirdMoodTag = HouseMoodTagView(roomMood: "재미있는")
    let fourthMoodTag = HouseMoodTagView(roomMood: "Chill한")
    private let roomMoodSeparatorView = UIView()
    private let groundRuleTitleLabel = UILabel()
    private let groundRuleStackView = UIStackView()
    let groundRuleLabel1 = CheckIconLabel(text: "아침마다 뉴진스 디토를 들으며 요가를 해요, 그리고 두 줄이면 이렇게 됩니다.")
    let groundRuleLabel2 = CheckIconLabel(text: "chill 코드는 굉장히 많지만, 신경도 안 쓰는 chill guy일 때")
    let groundRuleLabel3 = CheckIconLabel(text: "chill 코드는 굉장히 많지만, 신경도 안 쓰는 chill guy일 때")
    let groundRuleLabel4 = CheckIconLabel(text: "chill 코드는 굉장히 많지만, 신경도 안 쓰는 chill guy일 때")
    
    // roomStatus Section
    private let roomStatusTitleLabel = UILabel()
    let roomStatusTableView = UITableView()
    
    // facility Section
    private let facilityTitleLabel = UILabel()
    let safetyLivingFacilityView = HouseFacilityExpandView(title: "안전 및 생활시설")
    let kitchenFacilityView = HouseFacilityExpandView(title: "주방시설")
    private let facilityStackView = UIStackView()
    
    // roommate Section
    private let roommateTitleLabel = UILabel()
    let roommateTableView = UITableView()
    
    // bottom Button
    private let bottomButtonbackView = UIView()
    private let bottomButtonSeparatorView = UIView()
    let pinnedButton = RoomieIconButton(imageName: "icn_heart_24_normal", border: true)
    let contactButton = RoomieIconButton(imageName: "icn_inquire_24", border: true)
    let tourApplyButton = RoomieButton(title: "투어신청하기")
    
    // MARK: - UISetting
    
    override func setStyle() {
        scrollView.do {
            $0.contentInsetAdjustmentBehavior = .never
        }
        
        photoImageView.do {
            $0.backgroundColor = .grayscale4
        }
        
        roundedTopView.do {
            $0.backgroundColor = .grayscale1
            $0.roundCorners(cornerRadius: 16, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        }
        
        nameBackView.do {
            $0.backgroundColor = .primaryLight5
            $0.layer.cornerRadius = 4
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.primaryLight2.cgColor
            $0.clipsToBounds = true
        }
        
        nameLabel.do {
            $0.setText("해피쉐어 12호점", style: .body6, color: .primaryPurple)
        }
        
        titleLabel.do {
            $0.setText("월세 43~50/보증금 90~100", style: .heading2, color: .grayscale12)
        }
        
        firstIconLabelStackView.do {
            $0.axis = .horizontal
            $0.spacing = 0
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
        
        secondIconLabelStackView.do {
            $0.axis = .horizontal
            $0.spacing = 0
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
        
        houseInfoSeparatorView.do {
            $0.backgroundColor = .grayscale3
        }
        
        roomMoodTitleLabel.do {
            $0.setText("룸 분위기", style: .heading5, color: .grayscale12)
        }
        
        roomMoodBackView.do {
            $0.backgroundColor = .grayscale1
            $0.layer.borderColor = UIColor.grayscale5.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 8
        }
        
        roomMoodLabel.do {
            $0.setText("I got no time to lose 내 길었던 하루 난 보고 싶어 Ra-ta-ta-ta 울린 심장 (Ra-ta-ta-ta) I got nothing to lose 널 좋아한다고", style: .body1, color: .grayscale12)
        }
        
        roomMoodSeparatorView.do {
            $0.backgroundColor = .grayscale4
        }
        
        groundRuleTitleLabel.do {
            $0.setText("숙소 규칙", style: .body2, color: .grayscale12)
        }
        
        groundRuleStackView.do {
            $0.axis = .vertical
            $0.spacing = 8
            $0.alignment = .fill
            $0.distribution = .fill
        }
        
        roomStatusTitleLabel.do {
            $0.setText("입주현황", style: .heading5, color: .grayscale12)
        }
        
        roomStatusTableView.do {
            $0.separatorStyle = .none
        }
        
        facilityTitleLabel.do {
            $0.setText("내부시설 및 관리", style: .heading5, color: .grayscale12)
        }
        
        facilityStackView.do {
            $0.axis = .vertical
            $0.spacing = 12
            $0.alignment = .fill
            $0.distribution = .fill
        }
        
        roommateTitleLabel.do {
            $0.setText("룸메이트", style: .heading5, color: .grayscale12)
        }
        
        roommateTableView.do {
            $0.separatorStyle = .none
        }

        bottomButtonbackView.do {
            $0.backgroundColor = .grayscale1
        }
        
        bottomButtonSeparatorView.do {
            $0.backgroundColor = .grayscale5
        }
    }
    
    override func setUI() {
        addSubviews(scrollView, bottomButtonbackView)
        
        scrollView.addSubviews(contentView)
        
        contentView.addSubviews(
            photoImageView,
            nameBackView,
            titleLabel,
            firstIconLabelStackView,
            secondIconLabelStackView,
            contractTermIconLabel,
            lookInsidePhotoButton,
            houseInfoSeparatorView,
            roomMoodTitleLabel,
            roomMoodBackView,
            roomStatusTitleLabel,
            roomStatusTableView,
            facilityTitleLabel,
            facilityStackView,
            roommateTitleLabel,
            roommateTableView
        )

        photoImageView.addSubview(roundedTopView)
        
        nameBackView.addSubview(nameLabel)
        
        firstIconLabelStackView.addArrangedSubviews(locationIconLabel, occupancyTypesIconLabel)
        
        secondIconLabelStackView.addArrangedSubviews(occupancyStatusIconLabel, genderPolicyIconLabel)
        
        roomMoodBackView.addSubviews(
            roomMoodLabel,
            firstMoodTag,
            secondMoodTag,
            thirdMoodTag,
            fourthMoodTag,
            roomMoodSeparatorView,
            groundRuleTitleLabel,
            groundRuleStackView
        )
        
        // TODO: DataBind & 순서대로 addArrangedSubviews
        groundRuleStackView.addArrangedSubviews(
            groundRuleLabel1,
            groundRuleLabel2,
            groundRuleLabel3,
            groundRuleLabel4
        )
        
        facilityStackView.addArrangedSubviews(safetyLivingFacilityView, kitchenFacilityView)
        
        bottomButtonbackView.addSubviews(
            bottomButtonSeparatorView,
            pinnedButton,
            contactButton,
            tourApplyButton
        )
    }
    
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(bottomButtonbackView.snp.top)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualToSuperview().priority(.low)
        }
        
        photoImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Screen.height(316))
        }
        
        roundedTopView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Screen.height(20))
        }
        
        nameBackView.snp.makeConstraints {
            $0.top.equalTo(photoImageView.snp.bottom)
            $0.leading.equalToSuperview().inset(20)
        }
        
        nameLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(4)
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(nameBackView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        firstIconLabelStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
        
        secondIconLabelStackView.snp.makeConstraints {
            $0.top.equalTo(firstIconLabelStackView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        contractTermIconLabel.snp.makeConstraints {
            $0.top.equalTo(secondIconLabelStackView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        lookInsidePhotoButton.snp.makeConstraints {
            $0.top.equalTo(contractTermIconLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(HouseInnerPhotoButton.defaultHeight)
        }
        
        houseInfoSeparatorView.snp.makeConstraints {
            $0.top.equalTo(lookInsidePhotoButton.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Screen.height(8))
        }
        
        roomMoodTitleLabel.snp.makeConstraints {
            $0.top.equalTo(houseInfoSeparatorView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        roomMoodBackView.snp.makeConstraints {
            $0.top.equalTo(roomMoodTitleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        roomMoodLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        firstMoodTag.snp.makeConstraints {
            $0.top.equalTo(roomMoodLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
        }
        
        secondMoodTag.snp.makeConstraints {
            $0.top.equalTo(roomMoodLabel.snp.bottom).offset(16)
            $0.leading.equalTo(firstMoodTag.snp.trailing).offset(8)
        }
        
        thirdMoodTag.snp.makeConstraints {
            $0.top.equalTo(roomMoodLabel.snp.bottom).offset(16)
            $0.leading.equalTo(secondMoodTag.snp.trailing).offset(8)
        }
        
        fourthMoodTag.snp.makeConstraints {
            $0.top.equalTo(roomMoodLabel.snp.bottom).offset(16)
            $0.leading.equalTo(thirdMoodTag.snp.trailing).offset(8)
        }
        
        roomMoodSeparatorView.snp.makeConstraints {
            $0.top.equalTo(firstMoodTag.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        
        groundRuleTitleLabel.snp.makeConstraints {
            $0.top.equalTo(roomMoodSeparatorView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        groundRuleStackView.snp.makeConstraints {
            $0.top.equalTo(groundRuleTitleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        roomStatusTitleLabel.snp.makeConstraints {
            $0.top.equalTo(roomMoodBackView.snp.bottom).offset(48)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        roomStatusTableView.snp.makeConstraints {
            $0.top.equalTo(roomStatusTitleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(Screen.height(182 + 12))
        }
        
        facilityTitleLabel.snp.makeConstraints {
            $0.top.equalTo(roomStatusTableView.snp.bottom).offset(36)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        facilityStackView.snp.makeConstraints {
            $0.top.equalTo(facilityTitleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        roommateTitleLabel.snp.makeConstraints {
            $0.top.equalTo(facilityStackView.snp.bottom).offset(48)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        roommateTableView.snp.makeConstraints {
            $0.top.equalTo(roommateTitleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(Screen.height(102 + 12))
            $0.bottom.equalToSuperview().inset(8)
        }
        
        bottomButtonbackView.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Screen.height(80))
        }
        
        bottomButtonSeparatorView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        pinnedButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-12)
            $0.width.equalTo(pinnedButton.snp.height)
        }
        
        contactButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalTo(pinnedButton.snp.trailing).offset(8)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-12)
            $0.width.equalTo(pinnedButton.snp.height)
        }
        
        tourApplyButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalTo(contactButton.snp.trailing).offset(8)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-12)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}

// MARK: - Functions

extension HouseDetailView {
    /// roomStatusTableView의 높이를 동적으로 계산하는 함수입니다.
    func updateRoomStatusTableViewHeight(
        _ numberOfItems: Int,
        height roomStatusCellHeight: CGFloat
    ) {
        let tableViewHeight = CGFloat(numberOfItems) * roomStatusCellHeight
    
        roomStatusTableView.snp.updateConstraints {
            $0.height.equalTo(tableViewHeight)
        }
    }
    
    func updateRoommateTableViewHeight(
        _ numberOfItems: Int,
        height roommateCellHeight: CGFloat
    ) {
        let cellCount = numberOfItems == 0 ? 1 : numberOfItems
        let tableViewHeight = CGFloat(cellCount) * roommateCellHeight
        
        roommateTableView.snp.updateConstraints {
            $0.height.equalTo(tableViewHeight)
        }
    }
}
