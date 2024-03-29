//
//  CreateCommitScreenDataSource.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/1/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

class CreateCommitScreenDataSource: NSObject, BaseInputDataSource {
    
    // - Delegate
    weak var delegate: CreateCommitScreenViewController?
    
    // - UI
    unowned let tableView: UITableView
    
    // - Data
    var cells: [(cell: Cell, config: CellConfiguration?)] = []
    var activeTextViewCell: TextViewTableViewCell?
    private var commitAudioCellPage: CreateCommitAudioTableViewCell.Page = .uploadAudioFilePage
    
    // - Init
    init(tableView: UITableView, delegate: CreateCommitScreenDelegate) {
        self.tableView = tableView
        self.delegate = delegate as? CreateCommitScreenViewController
        super.init()
        subscribeToKeyboardNotifications()
        registerCells()
        configure()
    }
    
}

// MARK: -
// MARK: - Update

extension CreateCommitScreenDataSource {

    func update(setActiveTextViewCell targetConfig: CreateCommitTextViewCellConfiguration) {
        let textViewCellIndex = cells.firstIndex { (_, config) in
            targetConfig == (config as? CreateCommitTextViewCellConfiguration)
        }
        self.activeTextViewCell = textViewCell(atIndex: textViewCellIndex)
    }

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
    
    enum Cell: String {
        case chooseProjectCell = "ChooseProjectCell"
        case textViewCell = "textViewCell"
        case commitAudioCell = "CommitAudioCell"
        case sectionSeparatorCell = "sectionSeparatorCell"
    }
    
    private var commitAudioCellIndexPath: IndexPath? {
        if let commitAudioCellIndex = cells.firstIndex(where: { $0.cell == .commitAudioCell }) {
            return IndexPath(item: commitAudioCellIndex, section: 0)
        } else {
            return nil
        }
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
    
    private func commitAudioCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.commitAudioCell.rawValue, for: indexPath) as! CreateCommitAudioTableViewCell
        cell.backgroundColor = .clear
        cell.set(delegate: delegate, page: commitAudioCellPage)
        return cell
    }

}

// MARK: -
// MARK: - Delegate

extension CreateCommitScreenDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch cells[indexPath.item].cell {
            case .chooseProjectCell:
                delegate?.didTapChooseProjectCell()

            default:
                delegate?.forceDismissKeyboard()
        }
    }
    
}

// MARK: -
// MARK: - Keyboard

fileprivate extension CreateCommitScreenDataSource {

    @objc private func _keyboardWillShow(notification: NSNotification) {
        keyboardWillShow(notification: notification)
    }

    private func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(_keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
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
        appendCell(.textViewCell, config: CreateCommitTextViewCellConfiguration.commitNameTextView)
        appendCell(.textViewCell, config: CreateCommitTextViewCellConfiguration.commitDescriptionTextView)
        appendCell(.commitAudioCell)
        tableView.reloadData()
    }
    
    private func appendCell(_ cell: Cell, config: CellConfiguration? = nil) {
        cells.append((cell, config))
    }
    
}
