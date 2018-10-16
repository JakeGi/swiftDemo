//
//  DownloadViewController.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/15.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON

class DownloadViewController: PubBaseViewController {

    var userID:String?
    var codeImg = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()

       self.navigationItem.title = "下载"
        initSubUI()
        
        ZZDiskCacheHelper.getObj("userInfo") { (obj) in
            let  dic = obj! as!  [String : AnyObject]
            self.userID =  dic["userId"]! as? String
            
             self.getCodeData()
        }
        
       
    }
    
    func initSubUI(){
        let titleLab = UILabel()
        titleLab.text = "智能工程通"
        titleLab.textAlignment = NSTextAlignment.center
        titleLab.font = FontSize(16)
        self.view.addSubview(titleLab)
        
        let codeImg = UIImageView()
        self.view.addSubview(codeImg)
        self.codeImg = codeImg
        
        
        let tipLab = UILabel()
        tipLab.text = "扫描二维码下载app"
        tipLab.textAlignment = NSTextAlignment.center
        tipLab.font = FontSize(15)
        self.view.addSubview(tipLab)
        
        let describeLab = UILabel()
        describeLab.text = "本产品已在各大应用商店上架,请您放心下载"
        describeLab.textAlignment = NSTextAlignment.center
        describeLab.font = FontSize(15)
        self.view.addSubview(describeLab)
        
        titleLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        codeImg.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLab.snp.bottom).offset(20)
            make.width.equalTo(kScreenW-80)
            make.height.equalTo(kScreenW-80)
        }
        tipLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(codeImg.snp.bottom).offset(40)
        }
        
        describeLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(tipLab.snp.bottom).offset(10)
        }

        
    }
    
    func getCodeData(){
        
        let paramters : [String: String] = [
            "userId":self.userID!

        ]
    
        HTTP.GET(BaseUrl+uAPI_User_Help_Donwload, parameters: paramters) { response in
            if let err = response.error {
                print("error: \(err.localizedDescription)")
                return
            }
            let newsData = JSON(response.data)
        
            print(newsData)
    
            //主线程刷新UI
            DispatchQueue.main.async(execute: {
                let url = URL(string:BaseUrl+newsData["path"].stringValue)

                self.codeImg.kf.setImage(with: url)
            })
            
        }
    }
}
