//
//  WaveformViewInterface.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/15/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import struct UIKit.CGFloat

protocol IWaveformView: class {
    func createAndDisplayOneSecondInterval(locationX: CGFloat) -> (intervalView: CommitSelectedIntervalView, endX: CGFloat)?
}
