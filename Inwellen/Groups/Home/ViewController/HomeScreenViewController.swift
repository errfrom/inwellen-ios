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
    @IBOutlet weak var topSectionView: UIView!
    @IBOutlet var noFavoriteProjectsBanner: UIView!
    weak var projectShelfView: ProjectShelfView!

    // - Constraints
    @IBOutlet weak var topSectionViewTopConstraint: NSLayoutConstraint!

    // - DataSource
    private(set) var dataSource: HomeScreenDataSource!

    // - Manager
    private var layoutManager: HomeScreenLayoutManager!
    private var coordinator: HomeScreenCoordinator!

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
        layoutManager.populateTopSectionView(shouldDisplayProjectShelf: true)
        projectShelfView.set(models: models.map(ProjectShelfViewItemModel.init), delegate: self)
    }

}

// MARK: -
// MARK: - Action

fileprivate extension HomeScreenViewController {

    @IBAction private func didTapHideNoFavoriteProjectsBanner(_ sender: UIButton) {
        layoutManager.removeNoFavoriteProjectsBanner()
    }

    @IBAction private func didTapCreateNewProjectButton(_ sender: UIButton) {
        coordinator.moveToNewProjectScreen()
    }

}

// MARK: -
// MARK: - Delegate

extension HomeScreenViewController: HomeScreenDelegate {
 
    func didSelectProjectCell(projectPreview: ProjectPreviewModel) {
        // coordinator.moveToProjectCardScreen()
    }

    func layoutTopSectionView(isHidden: Bool) {
        layoutManager.layoutTopSectionView(isHidden: isHidden)
    }

    func didRequestContentRefreshing(_ completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: completion) // - TODO:
    }

    // MARK: - ProjectShelfViewDelegate

    func projectShelf(didSelectProjectWithId id: ID<ProjectPreviewModel>?) {
        coordinator.moveToProjectCardScreen()
    }

    func projectShelf(didScrollToProjectWithId id: ID<ProjectPreviewModel>?) {
        if let projectId = id {
            dataSource.update(scrollToProjectCellWithId: projectId)
        }
    }

}

// MARK: -
// MARK: - Configure

fileprivate extension HomeScreenViewController {

    private func configure() {
        configureDataSource()
        configureLayoutManager()
        configureCoordinator()
    }

    private func configureDataSource() {
        dataSource = HomeScreenDataSource(tableView: tableView, delegate: self)
    }

    private func configureLayoutManager() {
        layoutManager = HomeScreenLayoutManager(vc: self)
    }

    private func configureCoordinator() {
        coordinator = HomeScreenCoordinator(vc: self)
    }

}
