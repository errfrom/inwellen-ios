//
//  ChooseProjectScreenDataSource.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/1/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

class ChooseProjectScreenDataSource: NSObject {
    
    // - Delegate
    private weak var delegate: ChooseProjectScreenDelegate?
    
    // - UI
    private unowned let tableView: UITableView!
    
    // - Data
    private var models: [ChooseProjectItemTestModel] = [
        ChooseProjectItemTestModel(coverImage: UIImage(named: "test-project")!, projectTitle: "Long Time Coming", projectAuthor: "eluvium"),
        ChooseProjectItemTestModel(coverImage: UIImage(named: "test-project-2")!, projectTitle: "Talk Amongst the Trees", projectAuthor: "Hearts and Rockets"),
        ChooseProjectItemTestModel(coverImage: UIImage(named: "test-project-3")!, projectTitle: "Workout / Dead As Disco", projectAuthor: "Hearts and Rockets")
    ]
    
    // - Init
    init(tableView: UITableView, delegate: ChooseProjectScreenDelegate) {
        self.tableView = tableView
        self.delegate = delegate
        super.init()
        configure()
    }
    
}

// MARK: -
// MARK: - DataSource

extension ChooseProjectScreenDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseProjectItemCell", for: indexPath) as! ChooseProjectItemTableViewCell
        cell.backgroundColor = .clear
        cell.set(model: models[indexPath.item])
        return cell
    }
    
}

// MARK: -
// MARK: - Delegate

extension ChooseProjectScreenDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTapProjectCell()
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension ChooseProjectScreenDataSource {
    
    private func configure() {
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}
