//
//  DatePickerView.swift
//  Roomie
//
//  Created by 김승원 on 1/12/25.
//

import UIKit

import SnapKit
import Then

final class DatePickerView: UIView {
    
    // MARK: - Property
    
    static let defaultHeight: CGFloat = Screen.height(54)
    
    // MARK: - UIComponent
    
    private let dateLabel = UILabel()
    private let calendarIcon = UIImageView()
    let pickerButton = UIButton()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
        
        setPickerView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setPickerView()
    }
    
    // MARK: - UISetting
    
    private func setStyle() {
        dateLabel.do {
            // TODO: 피커 날짜 현재 날짜로 하는지, 2025/01/01로 고정인지 질문
            $0.setText("2025/01/01", style: .body1, color: .grayscale6)
            //            $0.setText(dateFormat(date: Date()), style: .body1, color: .grayscale6)
        }
        
        calendarIcon.do {
            $0.image = .icnCalender24
            $0.tintColor = .grayscale6
        }
    }
    
    private func setUI() {
        backgroundColor = .grayscale2
        layer.borderColor = UIColor.grayscale5.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        clipsToBounds = true
        
        addSubviews(
            dateLabel,
            calendarIcon,
            pickerButton
        )
    }
    
    private func setLayout() {
        dateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(calendarIcon.snp.leading).offset(-5)
        }
        
        calendarIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(Screen.height(26))
            $0.width.equalTo(Screen.width(26))
        }
        
        pickerButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - Function

private extension DatePickerView {
    func setPickerView() {
        pickerButton.addTarget(
            self,
            action: #selector(pickerDidTap),
            for: .touchUpInside
        )
    }
    
    func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        return formatter.string(from: date)
    }
    
    @objc
    func pickerDidTap() {
        print("눌림")
    }
    
    
    @objc
    func dateChange(_ sender: UIDatePicker) {
        dateLabel.updateText(dateFormat(date: sender.date))
    }
}
