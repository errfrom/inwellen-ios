//
//  UnisonTimePickerValue.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/8/21.
//  Copyright © 2021 Unison. All rights reserved.
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
        let digitsArray = Array(string)
        
        switch digitsArray.count {
            case 0:
                self.init(base: 0)
            
            case 1, 2:
                self.init(base: Int(string) ?? 0)
            
            case 3:
                let minutes = digitsArray[0].wholeNumberValue ?? 0
                let seconds = Int(String(digitsArray[1...])) ?? 0
                self.init(base: minutes * 60 + seconds)
            
            case 4:
                let minutes = Int(String(digitsArray[0..<2])) ?? 0
                let seconds = Int(String(digitsArray[2...])) ?? 0
                self.init(base: minutes * 60 + seconds)
            
            default:
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
        return minutesFormatted + secondsFormatted
    }
    
}
