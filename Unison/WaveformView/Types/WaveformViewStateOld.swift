//
//  WaveformViewStateOld.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 9/14/20.
//  Copyright © 2020 Unison. All rights reserved.
//

import UIKit

struct WaveformViewStateOld {
    
    // - Data
    private var intervals: [WaveformIntervalModel] = []
    private var intervalID: Int = 0
    private let waveformViewWidth: CGFloat
    
    // - Init
    init(waveformViewWidth: CGFloat) {
        self.waveformViewWidth = waveformViewWidth
    }
    
}

// MARK: -
// MARK: - Interface

extension WaveformViewStateOld {
    
    mutating func addInterval(centerX: CGFloat, completion: @escaping ((WaveformIntervalModel) -> Void)) {
        if let interval = calcInterval(centerX: centerX) {
            let intervalModel = intervalToIntervalModel(interval)
            intervals.append(intervalModel)
            intervalID += 1
            completion(intervalModel)
        }
    }
    
    mutating func selectInterval(id: Int) {
        deselectInterval()
        
        if let index = intervals.firstIndex(where: { $0.id == id }) {
            intervals[index].selected = true
        }
    }
    
    mutating func deselectInterval() {
        if let index = intervals.firstIndex(where: { $0.selected }) {
            intervals[index].selected = false
        }
    }
    
    func changeInterval(id: Int, newStartX: CGFloat) {
        
    }
    
    func changeInterval(id: Int, newEndX: CGFloat) {
        
    }
    
}

// MARK: -
// MARK: - Internal

fileprivate extension WaveformViewStateOld {
    
    typealias Interval = (startX: CGFloat, endX: CGFloat)
    
    private func calcInterval(centerX: CGFloat) -> Interval? {
        let DefaultIntervalWidth: CGFloat = 20
        let MinIntervalWidth: CGFloat = 10
        let d = DefaultIntervalWidth / 2
        
        let points = intervals.map() { $0.startX } + intervals.map() { $0.endX }
        let closestLPoint = points.filter() { $0 < centerX }.max() ?? 0
        let closestRPoint = points.filter() { $0 > centerX }.min() ?? waveformViewWidth

        switch (closestLPoint, closestRPoint) {
            
            // - 1. Distance between the points
            // is less than the minimum allowed interval width
            case let (x1, x2) where x2 - x1 < MinIntervalWidth:
                return nil
            
            // - 2. Distance between the points
            // is enough to add a default width interval
            case let (x1, x2) where centerX - x1 > d && x2 - centerX > d:
                return (startX: centerX - d, endX: centerX + d)
            
            // - 3. Distance between the points is enough
            // but one of the neighboring points is too close
            case let (x1, x2) where x2 - x1 > DefaultIntervalWidth:
                if centerX - x1 < d {
                    return (startX: x1 + d, endX: x1 + 2*d)
                } else if x2 - centerX < d {
                    return (startX: x2 - 2*d, endX: x2 - d)
                }
            
            // - 4. Distance between the points
            // - is just enough to add a minimum width interval
            default:
                return (startX: closestLPoint, endX: closestRPoint)
                
        }
        
        return nil
    }
    
    private func intervalToIntervalModel(_ interval: Interval) -> WaveformIntervalModel {
        let IntervalDraggableViewWidth: CGFloat = 44
        
        let width = interval.endX - interval.startX + 2*IntervalDraggableViewWidth
        let origin = CGPoint(x: interval.startX - IntervalDraggableViewWidth, y: 0)
        let frame = CGRect(x: origin.x, y: origin.y, width: width, height: 90)
        let intervalView = WaveformSelectedIntervalView(frame: frame)
        
        return WaveformIntervalModel(view: intervalView, id: intervalID, startX: interval.startX, endX: interval.endX)
    }
    
}
