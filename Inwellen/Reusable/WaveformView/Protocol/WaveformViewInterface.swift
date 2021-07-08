//
//  WaveformViewInterface.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/15/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import struct UIKit.CGFloat

protocol IWaveformView: class {
    func createAndDisplayIntervalView(timeInterval: TimeInterval) -> CommitSelectedIntervalView?
}
