//
//  SignUpPhotoManager.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/29/23.
//

import UIKit
import PhotosUI

//MARK: extension for selecting photos from gallery
extension SignUpScreenViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print("DEBUG: info of the selected picture: \(results)")
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(
                    ofClass: UIImage.self,
                    completionHandler: { (image, error) in
                        DispatchQueue.main.async{
                            if let uwImage = image as? UIImage{
                                self.signUpScreen.buttonTakePhoto.setImage(
                                    uwImage.withRenderingMode(.alwaysOriginal),
                                    for: .normal
                                )
                                self.pickedImage = uwImage
                            }
                        }
                    }
                )
            }
        }
    }
}
//MARK: extension for using camera
extension SignUpScreenViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.signUpScreen.buttonTakePhoto.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedImage = image
        }else{
            // Do your thing for No image loaded...
        }
    }
}
