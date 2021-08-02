//
//  NewProjectScreenDataSource.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 24.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

final class NewProjectScreenDataSource: NSObject, BaseInputDataSource {

    // - Delegate
    weak var delegate: NewProjectScreenViewController?

    // - UI
    unowned let tableView: UITableView

    // - Data
    var cells: [(cell: Cell, config: CellConfiguration?)] = .init()
    var activeTextViewCell: TextViewTableViewCell?

    // - Init
    init(tableView: UITableView, delegate: NewProjectScreenDelegate) {
        self.tableView = tableView
        self.delegate = delegate as? NewProjectScreenViewController
        super.init()
        subscribeToKeyboardNotifications()
        registerCells()
        configure()
    }

}

// MARK: -
// MARK: - Update

extension NewProjectScreenDataSource {

    func update(setActiveTextViewCell targetConfig: NewProjectTextViewCellConfiguration) {
        let textViewCellIndex = cells.firstIndex { (_, config) in
            targetConfig == (config as? NewProjectTextViewCellConfiguration)
        }
        self.activeTextViewCell = textViewCell(atIndex: textViewCellIndex)
    }

}

// MARK: -
// MARK: - DataSource

// swiftlint:disable line_length

extension NewProjectScreenDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cells[indexPath.item].cell {
            case .textViewCell:
                return textViewCell(tableView, cellForRowAt: indexPath)

            case .sectionSeparatorCell:
                return sectionSeparatorCell(tableView, cellForRowAt: indexPath)

            case .projectCoverCell:
                return projectCoverCell(tableView, cellForRowAt: indexPath)

            default:
                return tableViewCell(tableView, cellForRowAt: indexPath)
        }
    }

    private func projectCoverCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.projectCoverCell.rawValue, for: indexPath)
        (cell as? UploadProjectCoverTableViewCell)?.set(coverImage: delegate?.requestModel.coverImage)
        cell.backgroundColor = .clear
        return cell
    }

    private func tableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cells[indexPath.item].cell.rawValue, for: indexPath)
        return cell
    }

}

// swiftlint:enable line_length

// MARK: -
// MARK: - Cell

extension NewProjectScreenDataSource {

    enum Cell: String, AnyCell {
        case textViewCell
        case sectionSeparatorCell
        case projectCoverCell
        case createProjectButtonCell
    }

    // MARK: - Configure Cells

    private func configureCells() {
        cells.removeAll()

        appendSectionSeparatorCell(.init("Upload project cover", showSeparatorLine: false))
        appendCell(.projectCoverCell)

        appendSectionSeparatorCell(.init("Project name & description", bottomMargin: 8))
        appendTextViewCell(.projectNameTextView)
        appendTextViewCell(.projectDescriptionTextView)

        appendSectionSeparatorCell(.init("Project type & author", topMargin: 40))
        appendTextViewCell(.projectAuthorTextView)

        appendCell(.createProjectButtonCell)

        tableView.reloadData()
    }

    private func appendCell(_ cell: Cell) {
        cells.append((cell, nil))
    }

    private func appendTextViewCell(_ configuration: NewProjectTextViewCellConfiguration) {
        cells.append((.textViewCell, configuration))
    }

    private func appendSectionSeparatorCell(_ configuration: SectionSeparatorCellConfiguration) {
        cells.append((.sectionSeparatorCell, configuration))
    }

}

// MARK: -
// MARK: - Keyboard

fileprivate extension NewProjectScreenDataSource {

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

fileprivate extension NewProjectScreenDataSource {

    private func configure() {
        configureTableView()
        configureCells()
    }

    private func configureTableView() {
        tableView.dataSource = self
    }

}
