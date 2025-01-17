//
//  PriceSlider.swift
//  Roomie
//
//  Created by 예삐 on 1/12/25.
//

import UIKit

import SnapKit
import Then

final class PriceSlider: UIControl {
    private enum Constant {
        static let barRatio = 1.0/6.0
    }
    
    private let minThumbButton = ThumbButton()
    private let maxThumbButton = ThumbButton()
    private let trackView = UIView()
    private let trackTintView = UIView()
    
    var minValue = 0.0 {
        didSet { self.min = self.minValue }
    }
    var maxValue = 500.0 {
        didSet { self.max = self.maxValue }
    }
    var min = 0.0 {
        didSet { self.updateLayout(self.min, true) }
    }
    var max = 500.0 {
        didSet { self.updateLayout(self.max, false) }
    }
    var minThumbColor = UIColor.grayscale1 {
        didSet { self.minThumbButton.backgroundColor = self.minThumbColor }
    }
    var maxThumbColor = UIColor.grayscale1 {
        didSet { self.maxThumbButton.backgroundColor = self.maxThumbColor }
    }
    var trackColor = UIColor.grayscale5 {
        didSet { self.trackView.backgroundColor = self.trackColor }
    }
    var trackTintColor = UIColor.primaryPurple {
        didSet { self.trackTintView.backgroundColor = self.trackTintColor }
    }
    
    private var previousTouchPoint = CGPoint.zero
    private var isMinThumbViewTouched = false
    private var isMaxThumbViewTouched = false
    private var leftConstraint: Constraint?
    private var rightConstraint: Constraint?
    private var thumbViewLength: Double {
        Double(self.bounds.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 터치 이벤트 정의
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        super.point(inside: point, with: event)
        
        /// minThumb 혹은 maxThumb를 탭한 경우에만 터치 이벤트가 유효
        return self.minThumbButton.frame.contains(point) || self.maxThumbButton.frame.contains(point)
    }
    
    ///  point 메서드에서 true를 반환받은 터치 이벤트가 시작될 때 불리는 메서드
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        
        previousTouchPoint = touch.location(in: self)
        isMinThumbViewTouched = self.minThumbButton.frame.contains(self.previousTouchPoint)
        isMaxThumbViewTouched = self.maxThumbButton.frame.contains(self.previousTouchPoint)
        
        /// 해당 터치 이벤트를 계속할지 결정
        if isMinThumbViewTouched {
            minThumbButton.isSelected = true
        } else {
            maxThumbButton.isSelected = true
        }
        
        return isMinThumbViewTouched || isMaxThumbViewTouched
    }
    
    /// beginTracking 메서드에서 true를 반환받은 터치 이벤트가 불리는 메서드 (드래그 시 계속하여 호출)
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.continueTracking(touch, with: event)
        
        let touchPoint = touch.location(in: self)
        defer {
            self.previousTouchPoint = touchPoint
            self.sendActions(for: .valueChanged)
        }
        
        /// 오토레이아웃을 통해 뷰의 위치 업데이트
        let drag = Double(touchPoint.x - self.previousTouchPoint.x)
        let scale = self.maxValue - self.minValue
        let scaledDrag = scale * drag / Double(self.bounds.width - self.thumbViewLength)
        
        if isMinThumbViewTouched {
            min = (min + scaledDrag)
                .clamped(to: (minValue...max))
        } else {
            max = (max + scaledDrag)
                .clamped(to: (min...maxValue))
        }
        
        return true
    }
    
    /// continueTracking 메서드에서 true를 반환받은 터치 이벤트가 끝났을 때 불리는 메서드
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        
        sendActions(for: .valueChanged)
        
        minThumbButton.isSelected = false
        maxThumbButton.isSelected = false
    }
    
    func updateLayout(_ value: Double, _ isMinThumb: Bool) {
        DispatchQueue.main.async {
            let length = self.bounds.width - self.thumbViewLength
            let startValue = value - self.minValue
            let offset = length * startValue / (self.maxValue - self.minValue)
            
            if isMinThumb {
                self.leftConstraint?.update(offset: offset)
            } else {
                self.rightConstraint?.update(offset: offset)
            }
            
            UIView.animate(withDuration: 0.2) {
                self.setNeedsLayout()
                self.layoutIfNeeded()
            }
        }
    }
    
    private func setStyle() {
        trackView.do {
            $0.backgroundColor = .grayscale5
            $0.isUserInteractionEnabled = false
        }
        
        trackTintView.do {
            $0.backgroundColor = .primaryPurple
            $0.isUserInteractionEnabled = false
        }
    }
    
    private func setUI() {
        addSubviews(trackView, trackTintView, minThumbButton, maxThumbButton)
    }
    
    private func setLayout() {
        minThumbButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview()
            $0.trailing.lessThanOrEqualTo(maxThumbButton.snp.leading)
            $0.width.equalTo(self.snp.height)
            leftConstraint = $0.leading.equalTo(self.snp.leading).priority(999).constraint
        }
        
        maxThumbButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(minThumbButton.snp.trailing)
            $0.trailing.lessThanOrEqualToSuperview()
            $0.width.equalTo(self.snp.height)
            rightConstraint = $0.leading.equalTo(self.snp.leading).priority(999).constraint
        }
        
        trackView.snp.makeConstraints {
            $0.leading.trailing.centerY.equalToSuperview()
            $0.height.equalTo(self).multipliedBy(Constant.barRatio)
        }
        
        trackTintView.snp.makeConstraints {
            $0.top.bottom.equalTo(trackView)
            $0.leading.equalTo(minThumbButton.snp.trailing)
            $0.trailing.equalTo(maxThumbButton.snp.leading)
        }
        
        updateLayout(self.min, true)
        updateLayout(self.max, false)
    }
}

final class ThumbButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = false
        self.backgroundColor = .grayscale1
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.grayscale5.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.height / 2
    }
}

private extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        min(max(self, limits.lowerBound), limits.upperBound)
    }
}
