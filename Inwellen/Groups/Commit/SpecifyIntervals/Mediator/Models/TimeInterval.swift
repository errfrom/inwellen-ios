//
//  TimeInterval.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/19/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

struct TimeInterval {
    let startTime: UnisonTimePickerValue
    let endTime: UnisonTimePickerValue
}

extension TimeInterval {
    
    init(startTimeBase: Int, endTimeBase: Int) {
        self.startTime = UnisonTimePickerValue(base: startTimeBase)
        self.endTime = UnisonTimePickerValue(base: endTimeBase)
    }
    
}
