//
//  UserMessageViewController.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/15.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit

class UserMessageViewController: PubBaseViewController {
    lazy var dataArr:NSMutableArray = []
    lazy var tableView : UITableView = {
    let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width:kScreenW, height: kScreenH - 64), style: UITableViewStyle.grouped)
        tableView.register(userMessageCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()
    
    var userName:String?
    var teamName:String?
    override func viewDidLoad() {
        super.viewDidLoad()

       self.navigationItem.title  = "用户信息"
        ZZDiskCacheHelper.getObj("userInfo") { (obj) in
            let  dic = obj! as!  [String : AnyObject]
//            self.userName = dic["userName"]! as? String
//            self.teamName = dic["teamName"]! as? String
            self.dataArr.add(dic["userName"]! as? String ?? "")
            self.dataArr.add(dic["teamName"]! as? String ?? "")
            self.dataArr.add("")

        }
        
        self.view.addSubview(tableView)
    }


}
extension UserMessageViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userMessageCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "userMessageCell")
        cell.updataCellUI(dataArr: self.dataArr, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! MessageHeadView
        return nil
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
}
