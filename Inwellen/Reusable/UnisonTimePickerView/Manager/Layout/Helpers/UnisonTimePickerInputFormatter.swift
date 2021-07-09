//
//  InwellenTimePickerInputFormatter.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/8/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

enum UnisonTimePickerInputFormatter {
    
    static func formatInput(string: String) -> String {
        let digitsArray = Array(string)
        
        switch digitsArray.count {
            case 0: return ":"
            case 1: return " : \(string)"
            case 2: return "  :\(string)"
            case 3: return " \(digitsArray[0]):" + String(digitsArray[1...])
            case 4: return String(digitsArray[0..<2]) + ":" + String(digitsArray[2..<4])
            default: return ":"
        }
    }
    
}
