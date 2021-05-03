//
//  CreateCommitScreenDataSource.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/1/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

class CreateCommitScreenDataSource: NSObject {
    
    // - Delegate
    private weak var delegate: CreateCommitScreenDelegate?
    
    // - UI
    private unowned let tableView: UITableView
    
    // - Data
    private var cells: [(cell: Cell, config: CellConfiguration?)] = []
    private var commitAudioCellPage: CreateCommitAudioTableViewCell.Page = .uploadAudioFilePage
    
    // - Init
    init(tableView: UITableView, delegate: CreateCommitScreenDelegate) {
        self.tableView = tableView
        self.delegate = delegate
        super.init()
        registerCells()
        configure()
    }
    
}

// MARK: -
// MARK: - Update

extension CreateCommitScreenDataSource {
    
    func update(commitAudioCellPage: CreateCommitAudioTableViewCell.Page) {
        self.commitAudioCellPage = commitAudioCellPage
        
        if let indexPath = commitAudioCellIndexPath {
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    func scrollToCommitAudioCellIfNeeded() {
        guard commitAudioCellPage == .specifyIntervalsPage else { return }
        
        if let indexPath = commitAudioCellIndexPath {
            if let cell = tableView.cellForRow(at: indexPath) {
                let contentOffset = CGPoint(x: 0, y: cell.frame.minY + 40)
                tableView.setContentOffset(contentOffset, animated: true)
            }
        }
    }
    
}

// MARK: -
// MARK: - Cell

extension CreateCommitScreenDataSource {
    
    private enum Cell: String {
        case chooseProjectCell = "ChooseProjectCell"
        case textViewCell = "TextViewCell"
        case commitAudioCell = "CommitAudioCell"
        case sectionSeparatorCell = "SectionSeparatorCell"
    }
    
    private var commitAudioCellIndexPath: IndexPath? {
        if let commitAudioCellIndex = cells.firstIndex(where: { $0.cell == .commitAudioCell }) {
            return IndexPath(item: commitAudioCellIndex, section: 0)
        } else {
            return nil
        }
    }
    
    func textViewCell(withConfig config: TextViewCellConfiguration) -> TextViewTableViewCell? {
        let textViewCellIndex = cells.firstIndex(where: { (cell, config_) in
            return cell == .textViewCell && config == (config_ as? TextViewCellConfiguration)
        })
        
        if let item = textViewCellIndex {
            let indexPath = IndexPath(item: item, section: 0)

            if let textViewCell = tableView.cellForRow(at: indexPath) as? TextViewTableViewCell {
                return textViewCell
            }
        }
        return nil
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
            case .textViewCell:
                return textViewCell(tableView, cellForRowAt: indexPath)
            case .commitAudioCell:
                return commitAudioCell(tableView, cellForRowAt: indexPath)
            case .sectionSeparatorCell:
                return sectionSeparatorCell(tableView, cellForRowAt: indexPath)
        }
    }
    
    private func chooseProjectCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.chooseProjectCell.rawValue, for: indexPath) as! CreateCommitChooseProjectTableViewCell
        cell.backgroundColor = .clear
        return cell
    }
    
    private func textViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.textViewCell.rawValue, for: indexPath) as! TextViewTableViewCell
        cell.backgroundColor = .clear
        if let config = cells[indexPath.item].config as? TextViewCellConfiguration {
            cell.set(withConfig: config, delegate: delegate)
        }
        return cell
    }
    
    private func commitAudioCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.commitAudioCell.rawValue, for: indexPath) as! CreateCommitAudioTableViewCell
        cell.backgroundColor = .clear
        cell.set(delegate: delegate, page: commitAudioCellPage)
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
        registerTextViewCell()
        registerSectionSeparatorCell()
    }
    
    private func registerTextViewCell() {
        let nib = UINib(nibName: "\(TextViewTableViewCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Cell.textViewCell.rawValue)
    }
    
    private func registerSectionSeparatorCell() {
        let nib = UINib(nibName: "\(SectionSeparatorTableViewCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Cell.sectionSeparatorCell.rawValue)
    }
    
}

// MARK: -
// MARK: - Delegate

extension CreateCommitScreenDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch cells[indexPath.item].cell {
            case .chooseProjectCell:
                delegate?.didTapChooseProjectCell()
            
            case .textViewCell:
                let cell = tableView.cellForRow(at: indexPath) as? TextViewTableViewCell
                cell?.makeTextViewFirstResponder()
            
            default:
                delegate?.forceDismissKeyboard()
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
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
    }
    
    private func configureCells() {
        cells.removeAll()
        appendCell(.sectionSeparatorCell, config: SectionSeparatorCellConfiguration("Choose project", showSeparatorLine: false))
        appendCell(.chooseProjectCell)
        appendCell(.sectionSeparatorCell, config: SectionSeparatorCellConfiguration("Name & description", bottomMargin: 8))
        appendCell(.textViewCell, config: TextViewCellConfiguration.commitNameTextView)
        appendCell(.textViewCell, config: TextViewCellConfiguration.commitDescriptionTextView)
        appendCell(.commitAudioCell)
        tableView.reloadData()
    }
    
    private func appendCell(_ cell: Cell, config: CellConfiguration? = nil) {
        cells.append((cell, config))
    }
    
}
