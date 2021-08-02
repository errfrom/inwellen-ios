//
//  BaseScreenCoordinator.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 31.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

// swiftlint:disable line_length

import UIKit

protocol BaseScreenCoordinator {
    associatedtype ViewController: UIViewController

    var vc: ViewController { get }

    func popViewController()
    func showDiscardChangesAlert(onDiscard: @escaping (UIAlertAction) -> Void)
}

extension BaseScreenCoordinator {

    func popViewController() {
        vc.navigationController?.popViewController(animated: true)
    }

    func showDiscardChangesAlert(onDiscard discardActionHandler: @escaping (UIAlertAction) -> Void) {
        let alert = Alert.discardChanges.controller
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel))
        alert.addAction(UIAlertAction(title: "Discard".localized(), style: .destructive, handler: discardActionHandler))
        vc.present(alert, animated: true)
    }

}
