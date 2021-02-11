//
//  ViewController.swift
//  SystemViewControllers
//
//  Created by Viktor Khotimchenko on 2021-02-10.
//

import MessageUI
import SafariServices
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "swift_cover")
    }

    @IBAction func onShareTap(_ sender: UIButton) {
        guard let image = imageView.image else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender
        present(activityController, animated: true)
    }

    @IBAction func onSafariTap(_ sender: UIButton) {
        if let url = URL(string: "https://www.apple.com") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true)
        }
    }

    @IBAction func onCameraTap(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self

        let ac = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            ac.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true)
            }))
        }

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            ac.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true)
            }))
            ac.popoverPresentationController?.sourceView = sender
        }

        present(ac, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }

        imageView.image = selectedImage
        dismiss(animated: true)
    }

    @IBAction func onEmailTap(_ sender: UIButton) {
        guard MFMailComposeViewController.canSendMail() else {
            print("Cannot send mail")
            return
        }

        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self

        mailComposer.setToRecipients(["example@example.com"])
        mailComposer.setSubject("Look at this")
        mailComposer.setMessageBody("Hello, this is an email from the app I made.", isHTML: false)

        if let image = imageView.image,
           let jpegData = image.jpegData(compressionQuality: 0.9)
        {
            mailComposer.addAttachmentData(jpegData, mimeType: "image/jpeg", fileName: "photo.jpg")
        }
        present(mailComposer, animated: true)
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true)
    }
}
