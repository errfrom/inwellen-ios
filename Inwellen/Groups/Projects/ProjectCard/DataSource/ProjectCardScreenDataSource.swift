//
//  ProjectCardScreenDataSource.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 12.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

final class ProjectCardScreenDataSource: NSObject {

    // - UI
    private unowned let tableView: UITableView

    // - Data

    // - Init
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        configure()
    }

}

// MARK: -
// MARK: - DataSource

extension ProjectCardScreenDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}

// MARK: -
// MARK: - Configure

fileprivate extension ProjectCardScreenDataSource {

    private func configure() {
        configureTableView()
    }

    private func configureTableView() {
        tableView.dataSource = self
    }

}
