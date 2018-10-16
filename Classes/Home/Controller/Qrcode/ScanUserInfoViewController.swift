//
//  ScanUserInfoViewController.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/10.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON


class ScanUserInfoViewController: PubBaseViewController {

    var userId:String?
    var scrollView:UIScrollView!
    var Model:userInfoMode!
    var trainHistoryListArr = [trainHistoryListModel]()
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: kScreenH - 64), style: UITableViewStyle.grouped)
        tableView.register(ScanUserInfoCell.classForCoder(), forCellReuseIdentifier: "ScanUserInfoCell")
        tableView.register(ScanLearRecordCell.classForCoder(), forCellReuseIdentifier: "ScanLearRecordCell")
        tableView.register(ScanUserInfoHeadView.classForCoder(), forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(ScanLearRecordHeadView.classForCoder(), forHeaderFooterViewReuseIdentifier: "ScanLearRecordHeadView")
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.tableFooterView = UIView()
        return tableView
    }()
    lazy var titleArr:[String] = {
        let arr:[String] = ["姓名:","年龄:","性别:","工号:","籍贯:","登记日期:","身份证号:","工种:","岗位:","所在班组:","状态:"]
        return arr
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "抽检人员信息"
        self.view.addSubview(tableView)
        requestData()
    }

    //请求数据
    func requestData(){
        
        let paramters : [String: String] = [
            "id":self.userId ?? "4305",
            ]
        
        HTTP.GET(BaseUrl+uAPI_User_UserInfo, parameters: paramters) { response in
            if let err = response.error {
                print("error: \(err.localizedDescription)")
                return //also notify app of failure as needed
            }
            let newsData = JSON(response.data)
            
            self.Model = userInfoMode(jsonData: newsData)
      
            
            let listdata = newsData["trainHistoryList"].arrayValue

            for dic in listdata{
//
                self.trainHistoryListArr.append(trainHistoryListModel(jsonDictionary: dic))
            }
                print("self.trainHistoryListArr\(self.trainHistoryListArr.count)")
//            //主线程刷新UI
            DispatchQueue.main.async(execute: {
//
                self.tableView.reloadData()
//
            })
            
//            {
//                "teamStr" : "隧道一班",
//                "teamId" : 1194,
//                "jobType" : 0,
//                "name" : "测试93",
//                "fileList" : [
//                {
//                "filePath" : "flieList_0_1538028837800.033203.jpeg",
//                "id" : 611,
//                "fileName" : "flieList_0_1538028837800.033203.jpeg",
//                "entryId" : 5577
//                }
//                ],
//                "attachmentFileNameList" : [
//                "flieList_0_1538028837800.033203.jpeg"
//                ],
//                "age" : 36,
//                "type" : 0,
//                "nativePlace" : "问题就是我们在这个领域存在于你自己个领域存在于你自己\345\216去争取自己想",
//                "enterTime" : "2018-09-27 00:00:00",
//                "jobNo" : "XZ-01-SD01-361",
//                "id" : 5577,
//                "workTypeStr" : "喷浆班",
//                "idCardNo" : "622722199012140217",
//                "remark" : "",
//                "workTypeId" : 9,
//                "photoPath" : "350142ec-2bd9-46c6-a59c-ac71242a9abb.jpeg",
//                "sex" : 1
//            }
            
        }
        
        
    }

}
extension ScanUserInfoViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return self.titleArr.count

        }else{
            return self.trainHistoryListArr.count

        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = ScanUserInfoCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "ScanUserInfoCell")
            if (self.Model != nil) {
                cell.updataCellUI(mode: self.Model!, indexPath: indexPath ,nameArr: self.titleArr)
            }
            return cell
        }else{
            let cell = ScanLearRecordCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "ScanLearRecordCell")
                cell.updataCellUI(mode: self.trainHistoryListArr[indexPath.row])


            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section == 0){
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! ScanUserInfoHeadView
            return header
        }else{
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ScanLearRecordHeadView") as! ScanLearRecordHeadView
            return header
        }

        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0 ){
            return 120
        }else{
            return 60
        }
    }
}
