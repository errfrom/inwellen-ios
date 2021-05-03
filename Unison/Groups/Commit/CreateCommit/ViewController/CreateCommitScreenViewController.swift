//
//  CreateCommitScreenViewController.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/1/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

class CreateCommitScreenViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var tableView: UITableView!
    
    // - DataSource
    private var dataSource: CreateCommitScreenDataSource!
    
    // - Manager
    private var keyboardManager: CreateCommitScreenKeyboardManager!
    private var coordinator: CreateCommitScreenCoordinator!
    
    // - Data
    private var activeTextView: TextViewCellType?
    
    var activeTextViewCell: TextViewTableViewCell? {
        guard let activeTextViewConfig = activeTextView else { return nil }
        return dataSource.textViewCell(withConfig: activeTextViewConfig)
    }
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
}

// MARK: -
// MARK: - Action

fileprivate extension CreateCommitScreenViewController {
    
    @IBAction private func didTapCloseButton(_ sender: UIButton) {
        coordinator.dismiss()
    }
    
}

// MARK: -
// MARK: - Delegate

extension CreateCommitScreenViewController: CreateCommitScreenDelegate {
    
    func didTapChooseProjectCell() {
        coordinator.moveToChooseProject()
    }
    
    func didTapUploadAudioFileButton() {
        dataSource.update(commitAudioCellPage: .specifyIntervalsPage)
    }
    
    func commitAudioCellDidPerformPageTransition() {
        dataSource.scrollToCommitAudioCellIfNeeded()
    }
    
    func forceDismissKeyboard() {
        self.view.endEditing(true)
    }
    
    // MARK: - TextViewTableViewCellDelegate
    
    func textViewDidUpdateHeight() {
        tableView.beginUpdates()
        tableView.endUpdates()
        keyboardManager.adjustTableViewContentOffsetIfNeeded()
    }
    
    func textViewWillBeginEditing(textViewCellType: TextViewCellType) {
        self.activeTextView = textViewCellType
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension CreateCommitScreenViewController {
    
    private func configure() {
        configureDataSource()
        configureKeyboardManager()
        configureCoordinator()
    }
    
    private func configureDataSource() {
        dataSource = CreateCommitScreenDataSource(tableView: tableView, delegate: self)
    }
    
    private func configureKeyboardManager() {
        keyboardManager = CreateCommitScreenKeyboardManager(vc: self)
    }
    
    private func configureCoordinator() {
        coordinator = CreateCommitScreenCoordinator(vc: self)
    }
    
}
