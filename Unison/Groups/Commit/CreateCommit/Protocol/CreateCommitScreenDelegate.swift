//
//  CreateCommitScreenDelegate.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/1/21.
//  Copyright © 2021 Unison. All rights reserved.
//

protocol CreateCommitScreenDelegate: TextViewTableViewCellDelegate {
    func didTapChooseProjectCell()
    func didTapUploadAudioFileButton()
    func forceDismissKeyboard()
}
