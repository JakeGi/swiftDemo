//
//  LoginViewController.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/8.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON
class LoginViewController: PubBaseViewController {

    let userName = UITextField ()
    let pasword = UITextField()
    let loginBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        creatUI()
    }
    
    func creatUI(){
        
        let bgImg = UIImageView()
        bgImg.image = UIImage(named: "login_bg.jpg")
        self.view.addSubview(bgImg)
        
        bgImg.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        let topImg = UIImageView()
        topImg.image = UIImage(named: "login_title")
        self.view.addSubview(topImg)
        
        topImg.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(100)
            make.centerX.equalTo(self.view)
            make.height.equalTo(40)
            make.width.equalTo(kScreenW-60)
        }
        
        userName.placeholder = "用户名"
        userName.text = "xz01"
        userName.font = FontSize(16)
        userName.borderStyle = .line
        userName.layer.borderColor = HexRGBAlpha(0x74ddf4,1).cgColor
        userName.layer.borderWidth  = 1.0
        userName.backgroundColor = kWhite;
        userName.clearButtonMode = UITextFieldViewMode.whileEditing;
        self.view.addSubview(userName)
        
        let userNameImg = UIImageView()
        userNameImg.frame = CGRect(x: 30, y: 0, width: 45, height: 40)
        userNameImg.image = UIImage(named: "icon_user2")
        userName.leftView = userNameImg
        userName.leftViewMode = UITextFieldViewMode.always
        
        
        userName.snp.makeConstraints { (make) in
            make.top.equalTo(topImg.snp.bottom).offset(80)
            make.left.equalTo(self.view).offset(30)
            make.right.equalTo(self.view).offset(-30)
            make.height.equalTo(40)

        }
        
        pasword.placeholder = "密码"
        pasword.font = FontSize(16)
        pasword.borderStyle = .line
        pasword.layer.borderColor = HexRGBAlpha(0x74ddf4,1).cgColor
        pasword.layer.borderWidth  = 1.0
        pasword.backgroundColor = kWhite;
        pasword.text = "1"
        pasword.clearButtonMode = UITextFieldViewMode.whileEditing;
        self.view.addSubview(pasword)
        
        let paswordImg = UIImageView()
        paswordImg.frame = CGRect(x: 30, y: 0, width: 45, height: 40)
        paswordImg.image = UIImage(named: "icon_pass2")
        pasword.leftView = paswordImg
        pasword.leftViewMode = UITextFieldViewMode.always
        
        
        pasword.snp.makeConstraints { (make) in
            make.top.equalTo(userName.snp.bottom).offset(30)
            make.left.equalTo(self.view).offset(30)
            make.right.equalTo(self.view).offset(-30)
            make.height.equalTo(40)
            
        }
        
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.backgroundColor = HexRGBAlpha(0x459ada,1)
        loginBtn.setTitleColor(kWhite, for: .normal)
        loginBtn.addTarget(self, action:#selector(loginBtnClcik) , for: .touchUpInside)

        self.view.addSubview(loginBtn)
        
        
        loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(pasword.snp.bottom).offset(60)
            make.left.equalTo(self.view).offset(30)
            make.right.equalTo(self.view).offset(-30)
            make.height.equalTo(40)
            
        }
        
    }
    //点击登录按钮

    @objc func loginBtnClcik(){
        
        userName.resignFirstResponder()
        pasword.resignFirstResponder()
        let paramters : [String: String] = [
            "username":userName.text!,
            "password":pasword.text!,
            "imei":readUUIDFromKeyChain()
        ]
        self.view.addSubview(self.logingView)
        self.logingView.startAnimating()
        HTTP.GET(BaseUrl+loginUrl, parameters: paramters) { response in
            if let err = response.error {
                print("error: \(err.localizedDescription)")
                return //also notify app of failure as needed
            }

            let userInfo = JSON(response.data)
            print(userInfo)

            var dic = Dictionary<String,Any>()
            dic["userName"] = userInfo["userName"].description
            dic["userId"] = userInfo["userId"].description
            dic["teamId"] = userInfo["teamId"].description
            dic["orgId"] = userInfo["orgId"].description
            dic["photo"] = userInfo["photo"].description
            dic["teamName"] = userInfo["teamName"].description
          
            ZZDiskCacheHelper.saveObj("userInfo", value: dic)

            let root = ZJTabBarController()
            self.present(root, animated: true, completion: {
                //主线程刷新UI
                DispatchQueue.main.async(execute: {
                    
                    self.logingView.stopAnimating()
                    
                })
            })
  
        }
        
        
    }


}
