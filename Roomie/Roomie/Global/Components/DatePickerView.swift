//
//  DatePickerView.swift
//  Roomie
//
//  Created by 김승원 on 1/12/25.
//

import UIKit
import Combine

import CombineCocoa
import SnapKit
import Then

protocol DatePickerViewDelegate: AnyObject {
    func pickerViewPopUp()
}

final class DatePickerView: UIView {
    
    // MARK: - Property
    
    static let defaultHeight: CGFloat = Screen.height(54)
    
    private let cancelBag = CancelBag()

    weak var delegate: DatePickerViewDelegate?
    
    // MARK: - UIComponent
    
    private let dateLabel = UILabel()
    private let calendarIcon = UIImageView()
    let pickerButton = UIButton()
    
    private let datePicker = UIPickerView()
    private let birthAlert = UIAlertController(
        title: "title test",
        message: "message test",
        preferredStyle: .alert
    )
    
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
        
        setStyle()
        setUI()
        setLayout()
        
        setPickerView()
    }
    
    // MARK: - UISetting
    
    private func setStyle() {
        dateLabel.do {
            $0.setText(dateFormat(date: Date()), style: .body1, color: .grayscale6)
        }
        
        calendarIcon.do {
            $0.image = .icnCalender24
            $0.tintColor = .grayscale6
        }
        
//        datePicker.do {
//            $0.datePickerMode = .date
//            $0.preferredDatePickerStyle = .wheels
//            $0.locale = Locale(identifier: "ko_KR")
//        }

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
        pickerButton.tapPublisher
            .sink {
                // TODO: DatePickerView popup
                print("눌렸습니다.")
                self.delegate?.pickerViewPopUp()
            }
            .store(in: cancelBag)
    }
    
    /// Date를 yyyy/MM/dd 형식의 문자열로 반환합니다.
    func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        return formatter.string(from: date)
    }
    
    @objc
    func dateChange(_ sender: UIDatePicker) {
        dateLabel.updateText(dateFormat(date: sender.date))
    }
}
