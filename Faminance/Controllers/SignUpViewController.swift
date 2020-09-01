//
//  SignUpViewController.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/09/01.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var mailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var alreadyHaveAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
        
        mailTextField.delegate = self
        passwordTextField.delegate = self
        usernameTextField.delegate = self
    }
    
    private func setDesign(){
        profileImageButton.layer.cornerRadius = profileImageButton.bounds.width / 2
        profileImageButton.layer.borderWidth = 1
        profileImageButton.layer.borderColor = UIColor.lightGray.cgColor
        
        mailTextField.layer.borderWidth = 1
        mailTextField.layer.borderColor = UIColor.lightGray.cgColor
        mailTextField.layer.cornerRadius = 5
        mailTextField.attributedPlaceholder = NSAttributedString(string: "メール", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "パスワード", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        usernameTextField.layer.borderWidth = 1
        usernameTextField.layer.borderColor = UIColor.lightGray.cgColor
        usernameTextField.layer.cornerRadius = 5
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "ユーザーの名前", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        registerButton.layer.cornerRadius = 10
        
        profileImageButton.addTarget(self, action: #selector(tappedProfileImageButton), for: .touchUpInside)
    }
    
    // 各テキストフィールドの完了ボタン押下時アクション
    @IBAction func mailTextFieldTappedDone(_ sender: Any) {
        self.view.endEditing(true)
    }
    @IBAction func passwordTextFieldTappedDone(_ sender: Any) {
        self.view.endEditing(true)
    }
    @IBAction func usenameTextFieldTappedDone(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    // プロフィール画像ボタン押下時アクション
    @objc private func tappedProfileImageButton() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
}


extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editImage = info[.editedImage] as? UIImage {
            profileImageButton.setImage(editImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info[.originalImage] as? UIImage {
            profileImageButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        profileImageButton.imageView?.contentMode = .scaleAspectFill
        profileImageButton.contentHorizontalAlignment = .fill
        profileImageButton.contentVerticalAlignment = .fill
        profileImageButton.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print(mailTextField.text)
        let emailIsEmpth = mailTextField.text?.isEmpty ?? false
        let passwordIsEmpty = passwordTextField.text?.isEmpty ?? false
        let usernameIsEmpty = usernameTextField.text?.isEmpty ?? false
        
        if emailIsEmpth || passwordIsEmpty || usernameIsEmpty {
            registerButton.isEnabled = false
            registerButton.backgroundColor = .rgb(red: 100, green: 100, blue: 100)
        } else {
            registerButton.isEnabled = true
            registerButton.backgroundColor = .rgb(red: 26, green: 188, blue: 156)
            
        }
    }
}
