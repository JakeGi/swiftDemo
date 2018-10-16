//
//  NoticeViewController.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/9/29.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
import SwiftFCXRefresh
import SwiftHTTP
import SwiftyJSON
class NoticeViewController: PubBaseViewController {
    
    
    var listDataArr:NSMutableArray = []
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: view.width, height: view.height - 64), style: UITableViewStyle.grouped)
        tableView.register(NoticeCell.classForCoder(), forCellReuseIdentifier: "NoticeCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    var headerRefreshView: FCXRefreshHeaderView?
    var footerRefreshView: FCXRefreshFooterView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "公告通知"
        self.view.addSubview(tableView)
        addRefreshView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.requestData()
    }
    
    //下拉刷新
    func addRefreshView() {
        headerRefreshView = tableView.addFCXRefreshHeader { (refreshHeader) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.requestData()
                refreshHeader.endRefresh()
            }}.pullingPercentHandler(handler: { (percent) in
                print("current percent is", percent)
            })
        
        footerRefreshView = tableView.addFCXRefreshAutoFooter { [weak self] (refreshHeader) in
            print(refreshHeader)
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
    //请求数据
    func requestData(){
        
        self.listDataArr.removeAllObjects()
        ZZDiskCacheHelper.getObj("userInfo") { (obj) in
            let  dic = obj! as!  [String : AnyObject]
            let paramters : [String: String] = [
                "userId":dic["userId"]! as! String,
                "orgId":  dic["orgId"]! as! String,
                ]
            
            HTTP.GET(BaseUrl+uAPI_Notice_PublicList, parameters: paramters) { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                let userInfo = JSON(response.data).arrayValue
                 print(userInfo)
                for dic in userInfo{
                    let mode = NoticeModel(jsonData: dic)
                    self.listDataArr.add(mode)
                }
                //主线程刷新UI
                DispatchQueue.main.async(execute: {
                    
                    self.tableView.reloadData()

                })

            }
        }
        
        
    }
    
}

extension NoticeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.listDataArr.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NoticeCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "NoticeCell")
        let cellModel = self.listDataArr[indexPath.row] as! NoticeModel
        cell.showListData(mode: cellModel)
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
