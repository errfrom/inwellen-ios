//
//  HomeScreenViewController.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 9.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

final class HomeScreenViewController: UIViewController {

    // - UI
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var projectShelfView: ProjectShelfView!

    // - DataSource
    private var dataSource: HomeScreenDataSource!

    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()

        let models = [
            ProjectPreviewModel(
                projectId: .init(.int(value: 0)),
                projectName: "Long Time Coming",
                authorName: "eluvium",
                coverImage: UIImage(named: "test-project")),
            ProjectPreviewModel(
                projectId: .init(.int(value: 1)),
                projectName: "Talk Amongst the Trees",
                authorName: "Hearts and Rockets",
                coverImage: UIImage(named: "test-project-3")),
            ProjectPreviewModel(
                projectId: .init(.int(value: 2)),
                projectName: "Workout / Dead As Disco",
                authorName: "Myth",
                coverImage: UIImage(named: "test-project-2"))
        ]

        dataSource.update(models: models)
        projectShelfView.set(models: models.map(ProjectShelfViewItemModel.init), delegate: self)
    }

}

// MARK: -
// MARK: - Action

fileprivate extension HomeScreenViewController {

    @IBAction private func didTapAddProjectButton(_ sender: UIButton) {
        log.debug("Home: Did tap 'add project' button")
    }

}

// MARK: -
// MARK: - Delegate

extension HomeScreenViewController: HomeScreenDelegate {

    func didSelectProjectCell(projectPreview: ProjectPreviewModel) {
        log.debug("Home: Did select project cell with model: \(projectPreview)")
    }

    func projectShelf(didSelectProjectWithId id: ID<ProjectPreviewModel>?) {
        guard let projectId = id else { return }
        dataSource.update(scrollToProjectCellWithId: projectId)
    }

}

// MARK: -
// MARK: - Configure

fileprivate extension HomeScreenViewController {

    private func configure() {
        configureDataSource()
    }

    private func configureDataSource() {
        dataSource = HomeScreenDataSource(tableView: tableView, delegate: self)
    }

}
