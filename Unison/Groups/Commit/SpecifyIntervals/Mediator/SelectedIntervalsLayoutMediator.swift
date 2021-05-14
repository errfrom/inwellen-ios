//
//  SelectedIntervalsLayoutMediator.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/15/21.
//  Copyright © 2021 Unison. All rights reserved.
//

class SelectedIntervalsLayoutMediator: ISelectedIntervalsLayoutMediator {
    
    func notify(sender: ISelectedIntervalsLayoutComponent, event: SelectedIntervalsLayoutEvent) {
        log.debug("mediator -> got event: \(event)")
    }
    
}
