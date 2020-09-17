//
//  WaveformIntervalViewDelegate.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 9/16/20.
//  Copyright © 2020 Unison. All rights reserved.
//

protocol WaveformIntervalViewDelegate: class {
    func shouldSelectInterval(intervalID: Int)
}
