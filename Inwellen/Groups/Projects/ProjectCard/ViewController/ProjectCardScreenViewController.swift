//
//  ProjectCardScreenViewController.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 12.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

final class ProjectCardScreenViewController: UIViewController {

    // - UI
    @IBOutlet weak var tableView: UITableView!

    // - DataSource
    private var dataSource: ProjectCardScreenDataSource!

    // - Manager
    private var coordinator: ProjectCardScreenCoordinator!

    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

}

// MARK: -
// MARK: - Action

fileprivate extension ProjectCardScreenViewController {

    @IBAction private func didTapBackButton(_ sender: UIButton) {
        coordinator.pop()
    }

}

// MARK: -
// MARK: - Configure

fileprivate extension ProjectCardScreenViewController {

    private func configure() {
        configureCoordinator()
    }

    private func configureDataSource() {
        dataSource = ProjectCardScreenDataSource(tableView: tableView)
    }

    private func configureCoordinator() {
        coordinator = ProjectCardScreenCoordinator(vc: self)
    }

}
