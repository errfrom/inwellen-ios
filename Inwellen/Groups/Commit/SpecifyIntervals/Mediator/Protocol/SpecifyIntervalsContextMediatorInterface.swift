//
//  SpecifyIntervalsContextMediatorInterface.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/15/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import struct UIKit.CGFloat

protocol ISpecifyIntervalsContextMediator {
    func notify(sender: ISpecifyIntervalsContextComponent, event: SpecifyIntervalsContextEvent)
    var locationXToSecondRatio: CGFloat { get }
}
