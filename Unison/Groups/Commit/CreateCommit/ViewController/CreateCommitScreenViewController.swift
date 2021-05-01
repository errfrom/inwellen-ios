//
//  CreateCommitScreenViewController.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/1/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

class CreateCommitScreenViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var tableView: UITableView!
    
    // - DataSource
    private var dataSource: CreateCommitScreenDataSource!
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
}

// MARK: -
// MARK: - Action

fileprivate extension CreateCommitScreenViewController {
    
    @IBAction private func didTapBackButton(_ sender: UIButton) {
        
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension CreateCommitScreenViewController {
    
    private func configure() {
        configureDataSource()
    }
    
    private func configureDataSource() {
        dataSource = CreateCommitScreenDataSource(tableView: tableView)
    }
    
}
