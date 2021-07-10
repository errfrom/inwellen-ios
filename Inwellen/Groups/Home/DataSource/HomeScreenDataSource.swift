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

    // - Constants
    private let projectCellHeight: CGFloat = 441

    // - Data
    private var models: [ProjectPreviewModel] = .init()
    private var focusedModelIndex: Int = 0

    // - Init
    init(tableView: UITableView, delegate: HomeScreenDelegate) {
        self.tableView = tableView
        self.delegate = delegate
        super.init()
        configure()
    }

}

// MARK: -
// MARK: - Update

extension HomeScreenDataSource {

    func update(models: [ProjectPreviewModel]) {
        self.models = models
        tableView.reloadData()
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

extension HomeScreenDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeProjectCell", for: indexPath)
        (cell as? HomeProjectTableViewCell)?.set(projectPreview: models[indexPath.item])
        cell.backgroundColor = .clear
        return cell
    }

}

// MARK: -
// MARK: - Delegate

extension HomeScreenDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectProjectCell(projectPreview: models[indexPath.item])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return projectCellHeight
    }

}

// MARK: -
// MARK: - UIScrollViewDelegate

extension HomeScreenDataSource: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        // (contentOffsetY + projectCellHeight / 2) / projectCellHeight).rounded(.down)
    }

}

// MARK: -
// MARK: - Configure

fileprivate extension HomeScreenDataSource {

    private func configure() {
        configureTableView()
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }

}
