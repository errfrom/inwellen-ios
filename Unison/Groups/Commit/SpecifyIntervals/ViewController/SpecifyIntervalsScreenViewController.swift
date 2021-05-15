//
//  SpecifyIntervalsScreenViewController.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/2/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

class SpecifyIntervalsScreenViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var waveformView: WaveformView!
    
    // - DataSource
    private var dataSource: SpecifyIntervalsScreenDataSource!
    
    // - Mediator
    private var contextMediator: SpecifyIntervalsContextMediator!
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        super.hideKeyboardWhenTappedAround()
        configure()
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension SpecifyIntervalsScreenViewController {
    
    private func configure() {
        configureDataSource()
        configureContextMediator()
    }
    
    private func configureDataSource() {
        dataSource = SpecifyIntervalsScreenDataSource(tableView: tableView)
    }
    
    private func configureContextMediator() {
        contextMediator = SpecifyIntervalsContextMediator(waveformView: waveformView)
    }
    
}
