//
//  CreateCommitScreenDataSource.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/1/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

class CreateCommitScreenDataSource: NSObject {
    
    // - UI
    private unowned let tableView: UITableView
    
    // - Data
    private var cells: [(cell: Cell, config: CellConfiguration?)] = []
    
    // - Init
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        registerCells()
        configure()
    }
    
}

// MARK: -
// MARK: - DataSource

extension CreateCommitScreenDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cells[indexPath.item].cell {
            case .chooseProjectCell:
                return chooseProjectCell(tableView, cellForRowAt: indexPath)
            case .uploadAudio:
                return uploadAudioCell(tableView, cellForRowAt: indexPath)
            case .sectionSeparatorCell:
                return sectionSeparatorCell(tableView, cellForRowAt: indexPath)
        }
    }
    
    private func chooseProjectCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.chooseProjectCell.rawValue, for: indexPath) as! CreateCommitChooseProjectTableViewCell
        cell.backgroundColor = .clear
        return cell
    }
    
    private func uploadAudioCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.uploadAudio.rawValue, for: indexPath) as! CreateCommitUploadAudioTableViewCell
        cell.backgroundColor = .clear
        return cell
    }
    
    private func sectionSeparatorCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.sectionSeparatorCell.rawValue, for: indexPath) as! SectionSeparatorTableViewCell
        if let config = cells[indexPath.item].config as? SectionSeparatorCellConfiguration {
            cell.set(withConfig: config)
        }
        return cell
    }
    
}

// MARK: -
// MARK: - Register Cells

fileprivate extension CreateCommitScreenDataSource {
    
    private func registerCells() {
        registerSectionSeparatorCell()
    }
    
    private func registerSectionSeparatorCell() {
        let nib = UINib(nibName: "\(SectionSeparatorTableViewCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Cell.sectionSeparatorCell.rawValue)
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension CreateCommitScreenDataSource {
    
    private enum Cell: String {
        case chooseProjectCell = "ChooseProjectCell"
        case uploadAudio = "UploadAudioCell"
        case sectionSeparatorCell = "SectionSeparatorCell"
    }
    
    private func configure() {
        configureTableView()
        configureCells()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
    }
    
    private func configureCells() {
        cells.removeAll()
        appendCell(.sectionSeparatorCell, config: SectionSeparatorCellConfiguration("Choose project", showSeparatorLine: false))
        appendCell(.chooseProjectCell)
        appendCell(.sectionSeparatorCell, config: SectionSeparatorCellConfiguration("Name & description", bottomMargin: 8))
        appendCell(.sectionSeparatorCell, config: SectionSeparatorCellConfiguration("Upload commit audio"))
        appendCell(.uploadAudio)
        tableView.reloadData()
    }
    
    private func appendCell(_ cell: Cell, config: CellConfiguration? = nil) {
        cells.append((cell, config))
    }
    
}
