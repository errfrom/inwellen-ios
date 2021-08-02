//
//  BaseInputDataSource.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 24.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

protocol BaseInputDataSource: NSObject {
    associatedtype Delegate: TextViewCellDelegate
    associatedtype Cell

    var delegate: Delegate? { get }
    var tableView: UITableView { get }
    var cells: [(cell: Cell, config: CellConfiguration?)] { get }

    func registerCells()

    // swiftlint:disable line_length
    func textViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func sectionSeparatorCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell

    var activeTextViewCell: TextViewTableViewCell? { get }
    func textViewCell(atIndex index: Int?) -> TextViewTableViewCell?
    func keyboardWillShow(notification: NSNotification)
    func textViewDidUpdateHeight()
}

// MARK: -
// MARK: - Cell

fileprivate enum _Cell: String {
    case textViewCell
    case sectionSeparatorCell
}

// MARK: -
// MARK: - DataSource

extension BaseInputDataSource {

    func textViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: _Cell.textViewCell.rawValue, for: indexPath)
        cell.backgroundColor = .clear

        if let configuration = cells[indexPath.item].config as? TextViewCellConfiguration {
            (cell as? TextViewTableViewCell)?.set(configuration, delegate: delegate)
        }
        return cell
    }

    func sectionSeparatorCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: _Cell.sectionSeparatorCell.rawValue, for: indexPath)

        if let configuration = cells[indexPath.item].config as? SectionSeparatorCellConfiguration {
            (cell as? SectionSeparatorTableViewCell)?.set(withConfig: configuration)
        }
        return cell
    }

    // swiftlint:enable line_length

}

// MARK: -
// MARK: - Register Cells

extension BaseInputDataSource {

    func registerCells() {
        registerTextViewCell()
        registerSectionSeparatorCell()
    }

    private func registerTextViewCell() {
        let nib = UINib(nibName: "\(TextViewTableViewCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: _Cell.textViewCell.rawValue)
    }

    private func registerSectionSeparatorCell() {
        let nib = UINib(nibName: "\(SectionSeparatorTableViewCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: _Cell.sectionSeparatorCell.rawValue)
    }

}

// MARK: -
// MARK: - TextViewCell

extension BaseInputDataSource {

    func textViewCell(atIndex index: Int?) -> TextViewTableViewCell? {
        guard let index = index else { return nil }
        let indexPath = IndexPath(item: index, section: 0)
        return tableView.cellForRow(at: indexPath) as? TextViewTableViewCell
    }

    func textViewDidUpdateHeight() {
        tableView.updateRowHeightsWithoutReloading(animated: false)
        adjustTableViewContentOffsetIfNeeded()
    }

}

// MARK: -
// MARK: - Handle Keyboard

fileprivate var keyboardHeightKey: Void?

extension BaseInputDataSource {

    func keyboardWillShow(notification: NSNotification) {
        self.keyboardHeight = getKeyboardHeight(from: notification)
        adjustTableViewContentOffsetIfNeeded()
    }

    private func adjustTableViewContentOffsetIfNeeded() {
        guard let activeTextViewCell = activeTextViewCell else { return }
        tableView.superview?.layoutIfNeeded()

        guard let superviewMaxY = tableView.superview?.frame.maxY else { return }

        let cellMaxY = activeTextViewCell.frame.maxY
        let tableViewContentOffsetY = tableView.contentOffset.y
        let tabBarHeight = UIScreen.main.bounds.height - superviewMaxY

        // swiftlint:disable:next line_length
        let tableViewVisibleContentHeight = tableView.bounds.height - (keyboardHeight - tabBarHeight)
        let delta = cellMaxY + 24 - (tableViewContentOffsetY + tableViewVisibleContentHeight)

        if delta > 0 {
            let newContentOffset = CGPoint(x: 0, y: tableViewContentOffsetY + delta)
            tableView.setContentOffset(newContentOffset, animated: false)
        }
    }

    private func getKeyboardHeight(from notification: NSNotification) -> CGFloat {
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
        return (keyboardFrame as? NSValue)?.cgRectValue.height ?? 0
    }

    private var keyboardHeight: CGFloat {
        get {
            return objc_getAssociatedObject(self, &keyboardHeightKey) as? CGFloat ?? 0
        }

        set {
            objc_setAssociatedObject(
                self,
                &keyboardHeightKey,
                newValue,
                .OBJC_ASSOCIATION_COPY_NONATOMIC
            )
        }
    }

}
