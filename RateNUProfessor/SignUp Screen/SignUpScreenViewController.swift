//
//  SignUpScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit
import PhotosUI
import FirebaseStorage

class SignUpScreenViewController: UIViewController {
    
    let signUpScreen = SignUpScreenView()
    let childProgressView = ProgressSpinnerViewController()
    var pickedImage:UIImage?
    let storage = Storage.storage()
    var selectedCampus = "Boston"
    
    override func loadView() {
        view = signUpScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sign Up"
        
        signUpScreen.buttonTakePhoto.menu = getMenuImagePicker()
        
        signUpScreen.buttonRegister.addTarget(self, action: #selector(onButtonRegisterTapped), for: .touchUpInside)

    }
    
    func getMenuTypes() -> UIMenu{
        var menuItems = [UIAction]()
        
        for type in Campus.campus{
            let menuItem = UIAction(title: type,handler: {(_) in
                                self.selectedCampus = type
                                self.signUpScreen.buttonCampusSelected.setTitle(self.selectedCampus, for: .normal)
                            })
            menuItems.append(menuItem)
        }
        
        return UIMenu(title: "Select campus", children: menuItems)
    }
    
    @objc func onButtonRegisterTapped() {
        uploadProfilePhotoToStorage()
        let tabBarController = TabBarScreenViewController()
        self.navigationController?.pushViewController(tabBarController, animated: true)
    }
    
    func getMenuImagePicker() -> UIMenu{
        let menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                self.pickPhotoFromGallery()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    func pickUsingCamera(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    func pickPhotoFromGallery(){
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }

}
