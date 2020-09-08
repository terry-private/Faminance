//
//  SignUpViewController.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/09/01.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import UIKit
import Firebase


class SignUpViewController: UIViewController {
    var urlString = ""
    
    // ロードする時のクルクルを出す時、下に隠れてるバックグラウンドビューを全画面にする動きをさせてます。
    @IBOutlet weak var activityIndicatorBackgroundView: UIView! //  クルクルビューの薄暗いバックグラウンド
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView! // クルクルビュー
    @IBOutlet weak var indicatorTopMargin: NSLayoutConstraint! //   クルクルバックグラウンドのトップマージン
    
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
        
        validation()
        
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
        
        
        // profileImageButtonをタップ時のイベントを作成
        profileImageButton.addTarget(self, action: #selector(tappedProfileImageButton), for: .touchUpInside)
        
        // registerButtonタップ時のイベントを作成
        registerButton.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        
        indicatorTopMargin.constant = self.view.bounds.height
    }
    
    // profileImageButtonをタップ時のアクション
    @objc private func tappedProfileImageButton() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    // registerButtonタップ時のアクション
    // スレッドを分けてクルクルを出します。
    @objc private func tappedRegisterButton() {
        // アニメーションをスタート
        indicatorTopMargin.constant = 0
        self.activityIndicatorBackgroundView.backgroundColor = .rgb(red:0,green:0,blue:0,alpha:0.5)
        activityIndicatorView.startAnimating()
        // 通信系の処理をサブスレッドにて実行
        // サブスレッドの処理が終わったらメインスレッドに戻す
        DispatchQueue.global().async {
            self.createdUserToFirestore()
            DispatchQueue.main.async {
                // メインスレッドはUIの処理など
                // アニメーションをストップ
            }
        }
    }

    /// 順番が大切
    /// Authに登録してをログイン状態に
    /// imageを保存してURLをゲット
    /// usersにuser情報を保存
    private func createdUserToFirestore() {
        guard let mail = mailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let name = usernameTextField.text else { return }
        Auth.auth().createUser(withEmail: mail, password: password) { (res, err) in
            if let err = err {
                print("認証情報の保存に失敗しました。\(err)")
                return
            }
            guard let uid = res?.user.uid else { return }
            let docData = [
                "id": uid,
                "mail": mail,
                "password": password,
                "name": name,
                "createdAt": Date(),
                "profileImageURL": ""
            ] as [String: Any]
            self.uploadProfileImage(docData)
        }
    }
    
    // imageをアップロードしてダウンロードURLを返します。
    private func uploadProfileImage(_ docData: [String: Any]){
        guard let image = profileImageButton.imageView?.image else { self.setUserData(docData) ;return }
        guard let uploadImage = image.jpegData(compressionQuality: 0.3) else { self.setUserData(docData) ;return }
        
        let fileName = CurrentData.newId("img", Date.current)
        let storageRef = Storage.storage().reference().child("profile_image").child(fileName)
        
        storageRef.putData(uploadImage, metadata: nil) { (metadata, err) in
            if let err = err {
                print("Firestorageへの情報の保存に失敗しました。\(err)")
                return
            }
            storageRef.downloadURL { ( url, err) in
                if let err = err {
                    print("Firestorageからのダウンロードに失敗しました。\(err)")
                    return
                }
                var dic = docData
                dic["profileImageURL"] = url?.absoluteString ?? ""
                self.setUserData(dic)
                return
            }
        }
    }
    
    func setUserData(_ docData: [String: Any]){
        let uid = docData["id"] as? String ?? "noId"
        Firestore.firestore().collection("users").document(uid).setData(docData) { (err) in
            if let err = err {
                print("データベースへの保存に失敗しました。\(err)")
                return
            }
            print("Firestoreへの情報の保存が成功しました。")
            CurrentData.myAccount = User(dic: docData)
            self.dismiss(animated: true, completion: nil)
            self.activityIndicatorView.stopAnimating()
            self.indicatorTopMargin.constant = self.view.bounds.height
            self.activityIndicatorBackgroundView.backgroundColor = .rgb(red:0,green:0,blue:0,alpha:0)
        }
    }
    
    
    
    /// 入力値が正しい場合のみ確定ボタンを有効にします。
    func validation() {
        let emailValidation = validateEmail(mailTextField.text ?? "")
        let passwordValidation = passwordTextField.text?.count ?? 0 >= 6
        let usernameIsEmpty = usernameTextField.text?.isEmpty ?? false
        
        if !emailValidation || !passwordValidation || usernameIsEmpty {
            registerButton.isEnabled = false
            registerButton.backgroundColor = .rgb(red: 100, green: 100, blue: 100)
        } else {
            registerButton.isEnabled = true
            registerButton.backgroundColor = .rgb(red: 26, green: 188, blue: 156)
            
        }
    }
    
    /// mailアドレスとして正しいかどうか
    /// - Parameter enteredEmail: メールアドレス String型
    /// - Returns: Bool型で返します。
    func validateEmail(_ enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
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
        self.validation()
    }
}
