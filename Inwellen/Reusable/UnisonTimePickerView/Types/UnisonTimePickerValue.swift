//
//  InwellenTimePickerValue.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/8/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

struct UnisonTimePickerValue {
    
    // - Timestamp in seconds.
    var base: Int = 0
    
    // - Computed
    var minutes: Int {
        return base / 60
    }
    
    var seconds: Int {
        return base % 60
    }
    
}

// MARK: -
// MARK: - Parsing

extension UnisonTimePickerValue {
    
    init(fromTimeLabelString string: String) {
        let splitString = string
            .filter { !$0.isWhitespace }
            .split(separator: ":", maxSplits: 1, omittingEmptySubsequences: false)

        if splitString.count == 2 {
            let (minutes_, seconds_) = (Int(splitString[0]) ?? 0, Int(splitString[1]) ?? 0)
            self.init(base: minutes_ * 60 + seconds_)
        } else {
            self.init(base: 0)
        }
    }

}


// MARK: -
// MARK: - Formatting

extension UnisonTimePickerValue {
    
    private var minutesFormatted: String {
        return minutes > 9 ? "\(minutes)" : " \(minutes)"
    }
    
    private var secondsFormatted: String {
        return seconds > 9 ? "\(seconds)" : "0\(seconds)"
    }
    
    var timeLabelText: String {
        return "\(minutesFormatted):\(secondsFormatted)"
    }
    
    var textFieldInput: String {
        return String(minutes) + secondsFormatted
    }
    
}
