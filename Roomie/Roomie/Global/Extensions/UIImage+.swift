//
//  UIImage+.swift
//  Roomie
//
//  Created by MaengKim on 5/21/25.
//

import UIKit

extension UIImage {
    func resize(targetSize: CGSize) -> UIImage {
        let aspectRatio = size.width / size.height
        var newSize: CGSize
        
        if aspectRatio > 1 {
            newSize = CGSize(width: targetSize.width, height: targetSize.width / aspectRatio)
        } else {
            newSize = CGSize(width: targetSize.height * aspectRatio, height: targetSize.height)
        }
        
        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
