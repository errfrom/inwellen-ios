//
//  SpecifyIntervalsScreenDataSource.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/12/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

class SpecifyIntervalsScreenDataSource: NSObject {
    
    // - UI
    private unowned let tableView: UITableView
    
    // - Data
    private let cells: [Cell] = Array(repeating: .specifyIntervalCell, count: 2)
    
    // - Init
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        configure()
    }
    
}

// MARK: -
// MARK: - DataSource

extension SpecifyIntervalsScreenDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cells[indexPath.item] {
            case .specifyIntervalCell:
                return specifyIntervalCell(tableView, cellForRowAt: indexPath)
        }
    }
    
    private func specifyIntervalCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.specifyIntervalCell.rawValue, for: indexPath) as! SpecifyIntervalTableViewCell
        cell.backgroundColor = .clear
        return cell
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension SpecifyIntervalsScreenDataSource {
    
    private enum Cell: String {
        case specifyIntervalCell = "SpecifyIntervalCell"
    }
    
    private func configure() {
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
    }
    
}
