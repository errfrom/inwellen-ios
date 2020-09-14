//
//  WaveformViewStateDelegate.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 9/14/20.
//  Copyright © 2020 Unison. All rights reserved.
//

protocol WaveformViewStateDelegate: class {
    func didAddInterval(interval: WaveformViewState.WaveformViewInterval)
}
