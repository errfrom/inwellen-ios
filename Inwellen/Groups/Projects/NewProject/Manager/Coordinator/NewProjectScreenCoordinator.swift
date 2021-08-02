//
//  NewProjectScreenCoordinator.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 24.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit

final class NewProjectScreenCoordinator: NSObject, BaseScreenCoordinator {

    unowned let vc: NewProjectScreenViewController

    // - Init
    init(vc: NewProjectScreenViewController) {
        self.vc = vc
        super.init()
        configure()
    }

    func _popViewController() {
        guard vc.requestModel != NewProjectRequestModel() else {
            return popViewController()
        }

        showDiscardChangesAlert(onDiscard: { [weak self] _ in
            self?.popViewController()
        })
    }

}

// MARK: -
// MARK: - UIGestureRecognizerDelegate

extension NewProjectScreenCoordinator: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer === vc.navigationController?.interactivePopGestureRecognizer {
            _popViewController()
            return false
        } else {
            return true
        }
    }

}

// MARK: -
// MARK: - Configure

fileprivate extension NewProjectScreenCoordinator {

    private func configure() {
        configureInteractivePopGestureRecognizer()
    }

    private func configureInteractivePopGestureRecognizer() {
        vc.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

}
