//
//  ChooseProjectScreenViewController.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/1/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

class ChooseProjectScreenViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var tableView: UITableView!
    
    // - DataSource
    private var dataSource: ChooseProjectScreenDataSource!
    
    // - Manager
    private var coordinator: ChooseProjectScreenCoordinator!
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
}

// MARK: -
// MARK: - Action

fileprivate extension ChooseProjectScreenViewController {
    
    @IBAction private func didTapCloseButton(_ sender: UIButton) {
        coordinator.dismiss()
    }
    
}

// MARK: -
// MARK: - Delegate

extension ChooseProjectScreenViewController: ChooseProjectScreenDelegate {
    
    func didTapProjectCell() {
        coordinator.dismiss()
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension ChooseProjectScreenViewController {
    
    private func configure() {
        configureDataSource()
        configureCoordinator()
    }
    
    private func configureDataSource() {
        dataSource = ChooseProjectScreenDataSource(tableView: tableView, delegate: self)
    }
    
    private func configureCoordinator() {
        coordinator = ChooseProjectScreenCoordinator(vc: self)
    }
    
}
