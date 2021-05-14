//
//  SelectedIntervalsLayoutMediatorInterface.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/15/21.
//  Copyright © 2021 Unison. All rights reserved.
//

protocol ISelectedIntervalsLayoutMediator {
    func notify(sender: ISelectedIntervalsLayoutComponent, event: SelectedIntervalsLayoutEvent)
}
