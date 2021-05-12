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
    
    // - DataSource
    private var dataSource: SpecifyIntervalsScreenDataSource!
    
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
    }
    
    private func configureDataSource() {
        dataSource = SpecifyIntervalsScreenDataSource(tableView: tableView)
    }
    
}
