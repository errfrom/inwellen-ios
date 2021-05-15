//
//  SpecifyIntervalsContextEvent.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/15/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

enum SpecifyIntervalsContextEvent {
    case addIntervalRequest(locationX: CGFloat)
    case intervalLocationChangeRequest(dStartX: CGFloat?, dEndX: CGFloat?)
}
