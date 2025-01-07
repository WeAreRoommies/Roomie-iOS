//
//  UIStackView+.swift
//  Roomie
//
//  Created by 예삐 on 1/7/25.
//

import UIKit

extension UIStackView {    
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            self.addArrangedSubview($0)
        }
    }
}
