//
//  FilterSegmentedControl.swift
//  Roomie
//
//  Created by 예삐 on 1/11/25.
//

import UIKit

final class FilterSegmentedControl: UISegmentedControl {
    private let underlineView = UIView()
    
    override init(items: [Any]?) {
        super.init(items: items)
        
        setStyle()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let segmentFrames = segmentFrames()
        let labelFrames = segmentLabelFrames()
        
        guard selectedSegmentIndex < labelFrames.count,
              selectedSegmentIndex < segmentFrames.count
        else { return }
        
        let segmentFrame = segmentFrames[selectedSegmentIndex]
        let labelFrame = labelFrames[selectedSegmentIndex]
        
        UIView.animate(withDuration: 0.2) {
            self.underlineView.frame = CGRect(
                x: segmentFrame.minX + labelFrame.minX,
                y: self.bounds.height - 2.0,
                width: labelFrame.width,
                height: 2.0
            )
        }
    }
    
    private func setStyle() {
        self.do {
            $0.backgroundColor = .white
            $0.selectedSegmentTintColor = .clear
            
            $0.setBackgroundImage(
                UIImage(),
                for: .normal,
                barMetrics: .default
            )
            $0.setDividerImage(
                UIImage(),
                forLeftSegmentState: .normal,
                rightSegmentState: .normal,
                barMetrics: .default
            )
            
            $0.selectedSegmentIndex = 0
            $0.apportionsSegmentWidthsByContent = true
            
            let normalAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.grayscale12,
                .font: UIFont.pretendard(.body1)
            ]
            let selectedAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.primaryDark1,
                .font: UIFont.pretendard(.body2)
            ]
            
            setTitleTextAttributes(
                normalAttributes as [NSAttributedString.Key : Any],
                for: .normal
            )
            setTitleTextAttributes(
                selectedAttributes as [NSAttributedString.Key : Any],
                for: .selected
            )
        }
        
        underlineView.do {
            $0.backgroundColor = .primaryDark1
        }
    }
    
    private func setUI() {
        addSubview(underlineView)
    }
}

private extension FilterSegmentedControl {
    func segmentLabelFrames() -> [CGRect] {
        subviews
            .sorted { $0.frame.minX < $1.frame.minX }
            .compactMap { $0.subviews.first(where: { $0 is UILabel }) as? UILabel }
            .map { $0.frame }
    }
    
    func segmentFrames() -> [CGRect] {
        let temp = subviews
            .sorted { $0.frame.minX < $1.frame.minX }
            .compactMap { $0 as? UIImageView }
            .map { $0.frame }
        
        var frames = [CGRect]()
        for i in 0 ..< temp.count {
            if i % 2 == 0 {
                frames.append(temp[i])
            }
        }
        return frames
    }
}
