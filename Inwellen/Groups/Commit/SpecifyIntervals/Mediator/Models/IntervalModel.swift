//
//  IntervalModel.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/18/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import struct UIKit.CGFloat

struct IntervalModel {
    weak var intervalView: CommitSelectedIntervalView?
    
    let id: ID<Self>
    let startX: CGFloat
    let endX: CGFloat
}
