//
//  NotesViewController.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/15.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON
class NotesViewController: PubBaseViewController {

    var userID:String?
    var textView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "注意事项"
        initSubUI()
        
        ZZDiskCacheHelper.getObj("userInfo") { (obj) in
            let  dic = obj! as!  [String : AnyObject]
            self.userID =  dic["userId"]! as? String
            
            self.getNotesData()
        }
    }

    func initSubUI(){
        let textView = UITextView()
        textView.font = FontSize(15)
        self.view.addSubview(textView)
        self.textView = textView
        textView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(kScreenH-64)
        }
    }
    
    func getNotesData(){
        
        let paramters : [String: String] = [
            "userId":self.userID!
            
        ]
        
        HTTP.GET(BaseUrl+uAPI_User_Help_Items, parameters: paramters) { response in
            if let err = response.error {
                print("error: \(err.localizedDescription)")
                return
            }
            let responseData = JSON(response.data)
            
            let content = responseData["noticeMatters"].stringValue
            content.replacingOccurrences(of: "；", with: "。\n\n")
            self.textView.text = content
        
            print(responseData)
            
            //主线程刷新UI
            DispatchQueue.main.async(execute: {
                
            })
            
        }
    }

}
