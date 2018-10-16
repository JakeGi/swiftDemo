//
//  MessageViewController.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/9/27.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
import SwiftFCXRefresh
import SwiftHTTP
import SwiftyJSON

class MessageViewController: PubBaseViewController {

    var messageDataArr:NSMutableArray = []
    var userID:String?
    var userName:String?
    var messageCount:String?
    var page:Int = 1
    var pageSize:Int = 20
    var warningType:Int = 1
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 60, width: view.width, height: view.height - 64-60), style: UITableViewStyle.grouped)
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(MessageHeaderView.classForCoder(), forHeaderFooterViewReuseIdentifier: "header")
        return tableView
    }()
    
    var headerRefreshView: FCXRefreshHeaderView?
    var footerRefreshView: FCXRefreshFooterView?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = HexRGBAlpha(0xf4f4f4,1);
        let topView = MessageTopView()
        topView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 60)
        topView.delegate = self
        self.view.addSubview(topView)
        
        self.view .addSubview(tableView)
        
        addRefreshView()
        
        ZZDiskCacheHelper.getObj("userInfo") { (obj) in
            let  dic = obj! as!  [String : AnyObject]
            self.userID =  dic["userId"]! as? String
            self.userName = dic["userName"] as? String
        }
    }

    func addRefreshView() {
        headerRefreshView = tableView.addFCXRefreshHeader { (refreshHeader) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.requestData()
                self.RequestMonitorList()
                refreshHeader.endRefresh()
            }}.pullingPercentHandler(handler: { (percent) in
                print("current percent is", percent)
            })
        
        footerRefreshView = tableView.addFCXRefreshAutoFooter { [weak self] (refreshHeader) in
            self?.loadMoreAction()
        }
    }
    
    //上拉加载更多
    func loadMoreAction() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
            guard let weakSelf = self,
                let footerRefreshView = self?.footerRefreshView else {
                    return
            }
            
         
        }
        
    }
    //获取未读消息
    func requestData(){
        let paramters : [String: String] = [
            "userId":self.userID ?? "",
            "readStatus":"0",
            "loginName":self.userName ?? ""
            ]
        
        HTTP.GET(BaseUrl+uAPI_PCMO_Home_GetSendNum, parameters: paramters) { response in
            if let err = response.error {
                print("error: \(err.localizedDescription)")
                return //also notify app of failure as needed
            }
            let newsData = JSON(response.data)
            print(newsData["data"][0]["unreadNum"])
            
             self.messageCount = newsData["data"][0]["unreadNum"].stringValue
            //主线程刷新UI
            DispatchQueue.main.async(execute: {
                
                self.tableView.reloadData()
                
            })
            
        }
    }
    
    //拌合站列表
    func RequestMonitorList(){
        let paramters : [String: Any] = [
            "userId": self.userID ?? "",
            "readStatus":0,
            "warningType":self.warningType,
            "page":self.page,
            "size":self.pageSize
        ]
        
        HTTP.GET(BaseUrl+uAPI_Refer_MS_Station_List, parameters: paramters) { response in
            if let err = response.error {
                print("error: \(err.localizedDescription)")
                return //also notify app of failure as needed
            }
            let newsData = JSON(response.data)
            print(newsData)
    
            //主线程刷新UI
            DispatchQueue.main.async(execute: {
                
                self.tableView.reloadData()
                
            })
            
        }
    }
    
    

}
extension MessageViewController:UITableViewDelegate,UITableViewDataSource,MessageTopViewDeleget{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! MessageHeaderView
        header.titleLab.text = "未读消息\(self.messageCount ?? "")条"
        return header
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //顶部点击切换
    func cllBack(index: NSInteger) {
        print(index)
        self.warningType = index
        self.headerRefreshView?.autoRefresh()
    }
}
