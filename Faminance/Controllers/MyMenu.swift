//
//  MyMenu.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/09/06.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import UIKit
import Nuke
import Firebase

class MyMenuViewController: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var myMailLabel: UILabel!
    @IBOutlet weak var myTopView: MyTopView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myImageView.layer.cornerRadius = myImageView.bounds.width / 2
        myTopView.setTarget(self, selector: #selector(tappedMyTopView))
        myNameLabel.text = CurrentData.myAccount.name
        myMailLabel.text = CurrentData.myAccount.email
        setMyImage()
        
        let logoutBarButton = UIBarButtonItem(title: "ログアウト", style: .plain, target: self, action: #selector(tappedLogoutButton))
        navigationItem.leftBarButtonItem = logoutBarButton
    }
    
    @objc func tappedLogoutButton() {
        do {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
            let signUpViewController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
            signUpViewController.modalPresentationStyle = .fullScreen
            self.present(signUpViewController, animated: true, completion: nil)
        } catch {
            print("ログアウトに失敗しました。")
        }
    }
    
    @objc func tappedMyTopView(){
        print(CurrentData.myAccount.createdAt)
    }
    func setMyImage() {
        
        guard let url = URL(string: CurrentData.myAccount.profileImageURL) else {
            myImageView.image = UIImage(systemName: "camera")
            return
        }
        Nuke.loadImage(with: url, into: myImageView)
    }
}




/// MyTopViewのタッチイベントを作成するためにUIViwのサブクラスとして定義しておきます。
class MyTopView:UIView {
    private weak var target : AnyObject?
    private var selector : Selector?
    private var clickHandler: (() -> Void)?
    var highlightedColor: UIColor = .rgb(red:122, green: 122, blue: 122, alpha: 0.2)
    
    var highlighted : Bool = false {
        didSet{
            if (highlighted != oldValue){ reloadButtonColors() }
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func reloadButtonColors(){
        if highlighted {
            backgroundColor = highlightedColor
        } else {
            backgroundColor = .white
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlighted = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first

        var touchPoint : CGPoint = CGPoint.zero
        if let _touch = touch{
            touchPoint = _touch.location(in: self)
        }

        //タッチ領域から外れた場合はキャンセル扱いにする
        if(touchPoint.x > self.bounds.width || touchPoint.x < 0 || touchPoint.y > self.bounds.height || touchPoint.y < 0){
            touchesCancelled(touches, with: event)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!highlighted){
            return
        }

        if (target != nil && selector != nil && target!.responds(to: selector!)){
            let control : UIControl = UIControl()
            control.sendAction(selector!, to: target, for: nil)
        }

        if (clickHandler != nil){
            clickHandler!()
        }

        highlighted = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlighted = false
    }
    
    func setTarget(_ target: AnyObject, selector: Selector){
        self.target = target;
        self.selector = selector
    }
    
    func setClickHandler(handler : @escaping () -> Void){
        self.clickHandler = handler
    }
    
}
