//
//  PhotoViewController.swift
//  Core ML Demo
//
//  Created by 白彬涵 on 2017/9/18.
//  Copyright © 2017年 CMIOT. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let mlmodel = Resnet50()
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBAction func choose(_ sender: Any) {
        presentImagePicker()
    }
}


// MARK: - Life Circle
extension PhotoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - Pick Photo
extension PhotoViewController {
    func presentImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerVC = UIImagePickerController()
            imagePickerVC.sourceType = .camera
            imagePickerVC.delegate = self
            imagePickerVC.allowsEditing = true
            imagePickerVC.cameraCaptureMode = .photo
            imagePickerVC.cameraDevice = .rear
            self.present(imagePickerVC, animated: true, completion: nil)
        }
    }
}

// MARK: - UIImagePickerControllerDelegate
extension PhotoViewController {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancel")
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        contentImage.image = image
        let image224 = ImageProcessor.imageScaledToSize(sourceImage: image, size: CGSize(width: 224, height: 224))
        let result = try? mlmodel.prediction(image: ImageProcessor.pixelBuffer(forImage: image224.cgImage!)!)
        
        nameLabel.text = """
            name:\(result?.classLabel ?? "nil" ),
            confident:\(result?.classLabelProbs.filter({ (key, value) -> Bool in
                return key == result?.classLabel
            }).first?.value ?? 0.0)
        """
        self.dismiss(animated: true, completion: nil)
    }
}
