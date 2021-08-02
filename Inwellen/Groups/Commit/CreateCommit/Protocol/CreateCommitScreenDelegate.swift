//
//  CreateCommitScreenDelegate.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 5/1/21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

protocol CreateCommitScreenDelegate: TextViewCellDelegate {
    func didTapChooseProjectCell()
    func didTapUploadAudioFileButton()
    func commitAudioCellDidPerformPageTransition()
    
    func forceDismissKeyboard()
}
