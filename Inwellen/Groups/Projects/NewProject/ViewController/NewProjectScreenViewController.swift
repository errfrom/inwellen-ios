//
//  NewProjectScreenViewController.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 24.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

final class NewProjectScreenViewController: UIViewController {

    // - UI
    @IBOutlet weak var tableView: UITableView!

    // - DataSource
    private var dataSource: NewProjectScreenDataSource!

    // - Manager
    private var coordinator: NewProjectScreenCoordinator!
    private var imagePickerManager: ImagePickerManager!

    // - Data
    private(set) var requestModel = NewProjectRequestModel()

    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        configure()
    }

}

// MARK: -
// MARK: - Action

fileprivate extension NewProjectScreenViewController {

    @IBAction private func didTapBackButton(_ sender: UIButton) {
        coordinator._popViewController()
    }

    @IBAction private func didTapPickCoverImageButton(_ sender: UIButton) {
        let replacePickedImage = requestModel.coverImage != nil
        imagePickerManager.showImagePickerActionSheet(replacePickedImage: replacePickedImage) {
            [weak self] pickedImage in
                guard let strongSelf = self else { return }

                strongSelf.requestModel.coverImage = pickedImage
                strongSelf.tableView.reloadData()
        }
    }

}

// MARK: -
// MARK: - Delegate

extension NewProjectScreenViewController: NewProjectScreenDelegate {

    // MARK: - TextViewCellDelegate

    func textViewDidChange(_ text: String?, configuration: TextViewCellConfiguration) {
        let concreteConfiguration = configuration as! NewProjectTextViewCellConfiguration

        switch concreteConfiguration {
            case .projectNameTextView:
                requestModel.projectName = text

            case .projectDescriptionTextView:
                requestModel.projectDesc = text

            case .projectAuthorTextView:
                requestModel.authorName = text
        }
    }

    func textViewWillBeginEditing(configuration: TextViewCellConfiguration) {
        let concreteConfiguration = configuration as! NewProjectTextViewCellConfiguration
        dataSource.update(setActiveTextViewCell: concreteConfiguration)

        if case .projectAuthorTextView = concreteConfiguration {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        }
    }

    func textViewDidEndEditing(configuration: TextViewCellConfiguration) {
        let concreteConfiguration = configuration as! NewProjectTextViewCellConfiguration
        
        if case .projectAuthorTextView = concreteConfiguration {
            tableView.contentInset = .zero
        }
    }

    func textViewDidUpdateHeight() {
        dataSource.textViewDidUpdateHeight()
    }

}

// MARK: -
// MARK: - Configure

fileprivate extension NewProjectScreenViewController {

    private func configure() {
        configureDataSource()
        configureCoordinator()
        configureImagePickerManager()
    }

    private func configureDataSource() {
        dataSource = NewProjectScreenDataSource(tableView: tableView, delegate: self)
    }

    private func configureCoordinator() {
        coordinator = NewProjectScreenCoordinator(vc: self)
    }

    private func configureImagePickerManager() {
        imagePickerManager = ImagePickerManager(vc: self)
    }

}
