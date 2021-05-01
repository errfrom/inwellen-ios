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
    
    // - Init
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        configure()
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension CreateCommitScreenDataSource {
    
    private func configure() {
        
    }
    
}
