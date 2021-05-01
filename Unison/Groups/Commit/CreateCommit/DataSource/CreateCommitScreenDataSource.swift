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
    private var cells: [Cell] = []
    
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
        switch cells[indexPath.item] {
            case .chooseProjectCell:
                return chooseProjectCell(tableView, cellForRowAt: indexPath)
            case .uploadAudio:
                return uploadAudioCell(tableView, cellForRowAt: indexPath)
            case .sectionSeparatorCell:
                return sectionSeparatorCell(tableView, cellForRowAt: indexPath)
        }
    }
    
    private func chooseProjectCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.chooseProjectCell.id, for: indexPath) as! CreateCommitChooseProjectTableViewCell
        cell.backgroundColor = .clear
        return cell
    }
    
    private func uploadAudioCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.uploadAudio.id, for: indexPath) as! CreateCommitUploadAudioTableViewCell
        cell.backgroundColor = .clear
        return cell
    }
    
    private func sectionSeparatorCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.sectionSeparatorCellId, for: indexPath) as! SectionSeparatorTableViewCell
        if case .sectionSeparatorCell(let title, let showSeparatorLine) = cells[indexPath.item] {
            cell.set(sectionTitle: title, showSeparatorLine: showSeparatorLine)
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
        tableView.register(nib, forCellReuseIdentifier: Cell.sectionSeparatorCellId)
    }
    
}

// MARK: -
// MARK: - Cell

fileprivate extension CreateCommitScreenDataSource {
    
    private enum Cell {
        case chooseProjectCell
        case uploadAudio
        case sectionSeparatorCell(title: String, showSeparatorLine: Bool)
        
        var id: String {
            switch self {
                case .chooseProjectCell:
                    return "ChooseProjectCell"
                
                case .uploadAudio:
                    return "UploadAudioCell"
                
                case .sectionSeparatorCell:
                    return Cell.sectionSeparatorCellId
            }
        }
        
        static var sectionSeparatorCellId: String {
            return "SectionSeparatorCell"
        }
        
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension CreateCommitScreenDataSource {
    
    private func configure() {
        configureTableView()
        configureCells()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
    }
    
    private func configureCells() {
        cells.removeAll()
        cells.append(.sectionSeparatorCell(title: "Choose project", showSeparatorLine: false))
        cells.append(.chooseProjectCell)
        cells.append(.sectionSeparatorCell(title: "Name & description", showSeparatorLine: true))
        cells.append(.sectionSeparatorCell(title: "Upload commit audio", showSeparatorLine: true))
        cells.append(.uploadAudio)
        tableView.reloadData()
    }
    
}
