//
//  WaveformInternalView.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 9/14/20.
//  Copyright © 2020 Unison. All rights reserved.
//

import UIKit

class WaveformInternalView: UIView {
    
    // - Constants
    private let segmentWidth: Int = 3
    private let interitemSpace: Int = 5
    private let segmentCornerRadius: CGFloat = 1.5
    
    // - Lifecycle
    override func draw(_ rect: CGRect) {
        let (q, r) = Int(rect.width).quotientAndRemainder(dividingBy: segmentWidth + interitemSpace)
        let numSegments = segmentWidth < r ? q + 1 : q
        let horizontalMargin = segmentWidth < r ? (r - segmentWidth) / 2 : (segmentWidth / 2)
        
        let path = UIBezierPath()
        for segmentIndex in 0..<numSegments {
            let segmentRectX = horizontalMargin + segmentIndex * (segmentWidth + interitemSpace)
            let segmentRect = CGRect(x: segmentRectX, y: 0, width: segmentWidth, height: Int(rect.height))
            path.append(UIBezierPath(roundedRect: segmentRect, cornerRadius: segmentCornerRadius))
        }
        
        AppColor.lightGray.setFill()
        path.fill()
    }
    
}
