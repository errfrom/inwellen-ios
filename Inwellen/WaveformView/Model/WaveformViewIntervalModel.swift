//
//  WaveformViewIntervalModel.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 9/16/20.
//  Copyright © 2020 Inwellen. All rights reserved.
//

import UIKit

struct WaveformIntervalModel {
    
    var view: WaveformSelectedIntervalView
    
    let id: Int // TODO: ID Model
    let startX: CGFloat
    let endX: CGFloat
    
    var selected: Bool = true {
        didSet {
            view.selected = selected
        }
    }
    
    var viewWidth: CGFloat {
        return endX - startX
    }
    
    var points: [CGFloat] {
        return [startX, endX]
    }
    
}

