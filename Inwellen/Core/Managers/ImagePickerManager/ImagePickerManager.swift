//
//  ImagePickerManager.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 25.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit
import PhotosUI

final class ImagePickerManager: NSObject {

    private unowned let vc: UIViewController

    // - Typealias
    typealias Completion = (_ pickedImage: UIImage?) -> Void

    // - Data
    private var completion: Completion!

    // - Init
    init(vc: UIViewController) {
        self.vc = vc
        super.init()
    }

}

// MARK: -
// MARK: - Display ActionSheet

extension ImagePickerManager {

    func showImagePickerActionSheet(replacePickedImage: Bool, completion: @escaping Completion) {
        self.completion = completion

        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.view.tintColor = AppColor.richBlack
        actionSheet.addAction(chooseImageAction)

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actionSheet.addAction(cameraAction)
        }

        if replacePickedImage {
            actionSheet.addAction(removeImageAction)
        }

        actionSheet.addAction(cancelAction)
        vc.present(actionSheet, animated: true)
    }

    // MARK: - UIAlertAction

    private var cameraAction: UIAlertAction {
        return ImagePickerAction.cameraAction.alertAction { [weak self] in
            self?.presentImagePickerController(sourceType: .camera)
        }
    }

    private var chooseImageAction: UIAlertAction {
        return ImagePickerAction.chooseImageAction.alertAction { [weak self] in
            guard let strongSelf = self else { return }

            if #available(iOS 14.0, *) {
                strongSelf.presentPHPickerViewController()
            } else {
                strongSelf.presentImagePickerController(sourceType: .photoLibrary)
            }
        }
    }

    private var removeImageAction: UIAlertAction {
        return ImagePickerAction.removeImageAction.alertAction { [weak self] in
            self?.completion?(nil)
        }
    }

    private var cancelAction: UIAlertAction {
        return ImagePickerAction.cancelAction.alertAction()
    }

}

// MARK: -
// MARK: - UIImagePickerController

extension ImagePickerManager: UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    private func presentImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        imagePicker.mediaTypes = ["public.image"]
        imagePicker.allowsEditing = true

        vc.present(imagePicker, animated: true)
    }

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        picker.dismiss(animated: true)

        if let pickedImage = info[.editedImage] as? UIImage {
            completion(pickedImage)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

}

// MARK: -
// MARK: - PHPickerViewController

@available(iOS 14.0, *)
extension ImagePickerManager: PHPickerViewControllerDelegate {

    private func presentPHPickerViewController() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images

        let imagePicker = PHPickerViewController(configuration: configuration)
        imagePicker.delegate = self

        vc.present(imagePicker, animated: true)
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        if let pickerResult = results.first {
            let itemProvider = pickerResult.itemProvider

            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (pickedImage, _) in
                    guard let strongSelf = self else { return }

                    DispatchQueue.main.async {
                        strongSelf.completion(pickedImage as? UIImage)
                    }
                }
            }
        }
    }

}
