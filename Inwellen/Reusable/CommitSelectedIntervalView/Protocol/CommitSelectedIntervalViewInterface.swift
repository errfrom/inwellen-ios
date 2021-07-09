//
//  CommitSelectedIntervalViewInterface.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/15/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

protocol ICommitSelectedIntervalView: AnyObject {
    func setInitially(contextDirector: ISpecifyIntervalsContextMediator, timeInterval: TimeInterval)
    func updateTimeInterval(newStartTime: UnisonTimePickerValue)
    func updateTimeInterval(newEndTime: UnisonTimePickerValue)
}
