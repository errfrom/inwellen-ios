//
//  WaveformInternalView.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/12/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

class WaveformInternalView: UIView {
    
    // - Constants
    private struct Constant {
        static let segmentWidth: Int = 2
        static let interitemSpace: Int = 2
        static let segmentCornerRadius: CGFloat = 1
    }
    
    // - Data
    private var samples: [Float]? = nil
    
    // - Init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        samples = []
        for _ in 0..<100 {
            samples?.append(Float.random(in: 0...1))
        }
    }
    
    // - Draw
    override func draw(_ rect: CGRect) {
        let (numSegments, horizontalMargin) = getNumSegments(thatFitIntoRect: rect)
        guard let samples = samples, samples.count >= numSegments else { return }
        
        let path = UIBezierPath()
        zip(0..<numSegments, samples).forEach { (segmentIndex, sample) in
            let sample = sample >= 0.1 ? sample : 0.1
            
            let x = horizontalMargin + CGFloat(segmentIndex * (Constant.segmentWidth + Constant.interitemSpace))
            let y = (1 - CGFloat(sample)) * rect.height / 2
            let width = CGFloat(Constant.segmentWidth)
            let height = CGFloat(sample) * rect.height
            let segmentRect = CGRect(x: x, y: y, width: width, height: height)
            
            path.append(UIBezierPath(roundedRect: segmentRect, cornerRadius: Constant.segmentCornerRadius))
        }
        
        AppColor.darkBlueColor.setFill()
        path.fill()
    }
    
    private func getNumSegments(thatFitIntoRect rect: CGRect) -> (numSegments: Int, horizontalMargin: CGFloat) {
        let (quo, rem_) = Int(rect.width).quotientAndRemainder(dividingBy: Constant.segmentWidth + Constant.interitemSpace)
        let (numSegments, rem) = Constant.segmentWidth < rem_ ? (quo + 1, rem_ - Constant.segmentWidth) : (quo, rem_)
        let horizontalMargin = CGFloat(rem) / 2
        return (numSegments, horizontalMargin)
    }
    
}
