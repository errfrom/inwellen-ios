//
//  HomeScreenDataSource.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 9.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

final class HomeScreenDataSource: NSObject {

    // - Delegate
    private weak var delegate: HomeScreenDelegate?

    // - UI
    private unowned let tableView: UITableView

    // - Data
    private var cells: [Cell] = .init()
    private var models: [ProjectPreviewModel] = .init()

    // - Data: Layout
    private let actionButtonCellHeight: CGFloat = 128

    // - Data: Scrolling
    private var shouldHandleScrolling: Bool = false
    private var lastContentOffsetY: CGFloat = 0

    // - Init
    init(tableView: UITableView, delegate: HomeScreenDelegate) {
        self.tableView = tableView
        self.delegate = delegate
        super.init()
        registerScreenEmptyStateCell()
        configure()
    }

}

// MARK: -
// MARK: - Update

extension HomeScreenDataSource {

    func update(models: [ProjectPreviewModel]) {
        self.models = models
        configureCells()
    }

    func updateScreenEmptyStateCellHeight() {
        if case .screenEmptyStateCell = cells.first {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }

    func update(scrollToProjectCellWithId projectId: ID<ProjectPreviewModel>) {
        if let index = models.firstIndex(where: { $0.projectId == projectId }) {
            let indexPath = IndexPath(item: index, section: 0)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }

}

// MARK: -
// MARK: - DataSource

// swiftlint:disable line_length

extension HomeScreenDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cells[indexPath.item] {
            case .projectCell:
                return projectCell(tableView, cellForRowAt: indexPath)
            case .screenEmptyStateCell:
                return screenEmptyStateCell(tableView, cellForRowAt: indexPath)
            default:
                return tableViewCell(tableView, cellForRowAt: indexPath)
        }
    }

    private func projectCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.projectCell.rawValue, for: indexPath)
        (cell as? HomeProjectTableViewCell)?.set(projectPreview: models[indexPath.item], delegate: delegate)
        cell.backgroundColor = .clear
        return cell
    }

    private func screenEmptyStateCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.screenEmptyStateCell.rawValue, for: indexPath)
        (cell as? ScreenEmptyStateCell)?.set(.homeScreenEmptyState)
        cell.backgroundColor = .clear
        return cell
    }

    private func tableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cells[indexPath.item].rawValue, for: indexPath)
        cell.backgroundColor = .clear
        return cell
    }

}

// swiftlint:enable line_length

// MARK: -
// MARK: - UITableViewDelegate

extension HomeScreenDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if case .projectCell = cells[indexPath.item] {
            delegate?.didSelectProjectCell(projectPreview: models[indexPath.item])
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cells[indexPath.item] {
            case .projectCell:
                return UITableView.automaticDimension

            case .screenEmptyStateCell:
                return tableView.bounds.height - actionButtonCellHeight

            case .actionButtonCell:
                return actionButtonCellHeight
        }
    }

}

// MARK: -
// MARK: - UIScrollViewDelegate

extension HomeScreenDataSource: UIScrollViewDelegate {

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        shouldHandleScrolling = true
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !decelerate else { return }
        shouldHandleScrolling = false
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        shouldHandleScrolling = false
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.contentSize.height > scrollView.bounds.height else { return }
        guard shouldHandleScrolling else { return }

        let contentOffsetY = scrollView.contentOffset.y
        let noBouncingMaxContentOffsetY = scrollView.contentSize.height - scrollView.bounds.height

        if contentOffsetY > lastContentOffsetY, contentOffsetY > 0 {
            delegate?.layoutTopSectionView(isHidden: true)
            // swiftlint:disable:next line_length
        } else if contentOffsetY < lastContentOffsetY, lastContentOffsetY < noBouncingMaxContentOffsetY {
            delegate?.layoutTopSectionView(isHidden: false)
        }
        self.lastContentOffsetY = contentOffsetY
    }

}

// MARK: -
// MARK: - Cell

fileprivate extension HomeScreenDataSource {

    private enum Cell: String {
        case projectCell = "ProjectCell"
        case actionButtonCell = "ActionButtonCell"
        case screenEmptyStateCell = "ScreenEmptyStateCell"
    }

    private func registerScreenEmptyStateCell() {
        let nib = UINib(nibName: "\(ScreenEmptyStateCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Cell.screenEmptyStateCell.rawValue)
    }

}

// MARK: -
// MARK: - Configure

fileprivate extension HomeScreenDataSource {

    private func configure() {
        configureTableView()
        configureCells()
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func configureCells() {
        cells.removeAll()
        cells = Array(repeating: .projectCell, count: models.count)
        if models.isEmpty { cells.append(.screenEmptyStateCell) }
        cells.append(.actionButtonCell)
        tableView.reloadData()
    }

}
