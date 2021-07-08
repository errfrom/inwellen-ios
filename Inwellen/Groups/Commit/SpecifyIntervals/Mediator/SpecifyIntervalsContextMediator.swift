//
//  SpecifyIntervalsContextMediator.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/15/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import struct UIKit.CGFloat
import struct SortedArray.SortedArray

/* MARK: - Algorithm for creating and displaying an interval view.
 
    1. One of the components captures the request to create a new interval
    and sends it to the mediator.
 
    2. The mediator checks whether it's possible to add a new interval
    based on the information about the intervals already created.
 
    3. If it's possible to create an interval, the mediator calls the
    waveformView's `createAndDisplayIntervalView` function with
    a `TimeInterval` argument.
 
    4. The waveformView initializes an intervalView with the specified
    timeInterval.
 
    5. The newly created interval view uses the mediator's
    `locationXToSecondRatio` property to calculate the visible intervalView's
    width and set the corresponding width constraint.

    6. Once the interval view has been completely set up, the waveformView
    adds it to the view hierarchy constraint-based and returns it
    to the mediator.
 
    7. The mediator then assigns an id to the intervalView,
    wraps it in a special internal model, and adds it to the sorted array.
 
*/

// MARK: -
// MARK: - SpecifyIntervalsContextMediator

class SpecifyIntervalsContextMediator {
    
    // - Components
    private unowned var waveformView: IWaveformView
    
    // - Data
    let locationXToSecondRatio: CGFloat = 2
    
    private var intervalId: Int = 0
    private var intervals: SortedArray<IntervalModel> =
        SortedArray.init(areInIncreasingOrder: { $0.startX < $1.startX })
    
    // - Init
    init(waveformView: IWaveformView) {
        self.waveformView = waveformView
        configure()
    }
    
}

// MARK: -
// MARK: - Interface

extension SpecifyIntervalsContextMediator: ISpecifyIntervalsContextMediator {
    
    func notify(sender: ISpecifyIntervalsContextComponent, event: SpecifyIntervalsContextEvent) {
        switch event {
            case .addIntervalRequest(let locationX):
                guard let waveformView = sender as? IWaveformView else { return }
                handleAddIntervalRequest(sender: waveformView, locationX: locationX)
            
            case .intervalLocationChangeRequest(let dStartX, let dEndX):
                guard let intervalView = sender as? ICommitSelectedIntervalView else { return }
                handleIntervalLocationChangeRequest(sender: intervalView, dStartX, dEndX)
        }
    }
    
}

// MARK: -
// MARK: - Handle Events

fileprivate extension SpecifyIntervalsContextMediator {
    
    private func handleAddIntervalRequest(sender: IWaveformView, locationX: CGFloat) {
        log.debug("mediator -> got add interval request, locationX: \(locationX)")
        
        let startTimeBase = Int(locationX / locationXToSecondRatio)
        let endTimeBase = startTimeBase + 1
        if let intervalView = sender.createAndDisplayIntervalView(timeInterval: TimeInterval(startTimeBase: startTimeBase, endTimeBase: endTimeBase)) {
            print("OK")
        }
        
        // if let (intervalView, endX) = sender.createAndDisplayOneSecondInterval(locationX: locationX) {
        //    log.debug("mediator -> new interval with (startX: \(locationX), endX: \(endX))")
        //    let id: ID<IntervalModel> = .init(.int(value: self.intervalId))
        //    let intervalModel = IntervalModel(intervalView: intervalView, id: id, startX: locationX, endX: endX)
        //    intervals.insert(intervalModel)
        // }
    }
    
    private func handleIntervalLocationChangeRequest(sender: ICommitSelectedIntervalView, _ dStartX: CGFloat?, _ dEndX: CGFloat?) {
        log.debug("mediator -> got interval location change request, dStartX: \(dStartX.debugDescription), dEndX: \(dEndX.debugDescription)")
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension SpecifyIntervalsContextMediator {
    
    private func configure() {
        configureWaveformView()
    }
    
    private func configureWaveformView() {
        (waveformView as? WaveformView)?.specifyIntervalsContextDirector = self
    }
    
}
