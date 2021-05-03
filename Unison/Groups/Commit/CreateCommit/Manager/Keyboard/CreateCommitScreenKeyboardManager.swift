//
//  CreateCommitScreenKeyboardManager.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/3/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

class CreateCommitScreenKeyboardManager {
    
    private unowned let vc: CreateCommitScreenViewController
    
    // - Data
    private var keyboardHeight: CGFloat = 0
    
    // - Init
    init(vc: CreateCommitScreenViewController) {
        self.vc = vc
        subscribeToKeyboardNotifications()
    }
    
}

// MARK: -
// MARK: - Subscribe

fileprivate extension CreateCommitScreenKeyboardManager {
    
    private func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
}

// MARK: -
// MARK: - Handle Keyboard Events

extension CreateCommitScreenKeyboardManager {
        
    @objc private func keyboardWillShow(notification: NSNotification) {
        self.keyboardHeight = getKeyboardHeight(from: notification)
        adjustTableViewContentOffsetIfNeeded()
    }
    
    func adjustTableViewContentOffsetIfNeeded() {
        guard let activeTextViewCell = vc.activeTextViewCell else { return }
        vc.tableView.layoutIfNeeded()
        
        let cellMaxY = activeTextViewCell.frame.maxY
        let tableViewContentOffsetY = vc.tableView.contentOffset.y
        let tableViewVisibleContentHeight = vc.tableView.bounds.height - keyboardHeight
        let delta = cellMaxY + 24 - (tableViewContentOffsetY + tableViewVisibleContentHeight)
        
        if delta > 0 {
            let newContentOffset = CGPoint(x: 0, y: tableViewContentOffsetY + delta)
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.vc.tableView.setContentOffset(newContentOffset, animated: false)
            }
        }
    }
        
}

// MARK: -
// MARK: - Helpers

fileprivate extension CreateCommitScreenKeyboardManager {
    
    private func getKeyboardHeight(from notification: NSNotification) -> CGFloat {
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
        return (keyboardFrame as? NSValue)?.cgRectValue.height ?? 0
    }
    
}
