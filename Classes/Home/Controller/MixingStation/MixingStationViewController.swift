//
//  MixingStationViewController.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/9/29.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
import PGDatePicker
import SwiftHTTP
import SwiftyJSON
import SwiftFCXRefresh


class MixingStationViewController: PubBaseViewController {
    let titleArr:[String] = ["选择标段:","选择拌合机:","开始时间:","结束时间:"]
    let leaveArr:[String] = ["高级","中级","低级"]
    let imgIcoArr:[String] = ["warning_03","warning_02","warning_01"]
    var orgId:String?
    var startTime:String?
    var endTime:String?
    var MixerModels:MixerModel!
    var OrgMarkModels:OrgMarkModel!
    var ischange:String? //选择了开始时间还是结束时间
    var OrgMarkArr:NSMutableArray = []
    let alertView = AlertOrgListView()
    let MixerArr:NSMutableArray = []

    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y:titleArr.count*45+40+45, width: Int(kScreenW), height: Int(kScreenH)-titleArr.count*45+40), style: UITableViewStyle.grouped)
        tableView.register(MixingStationCell.classForCoder(), forCellReuseIdentifier: "MixingStationCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return tableView
    }()
    
    var headerRefreshView: FCXRefreshHeaderView?
    var footerRefreshView: FCXRefreshFooterView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "拌合站查询"
        creatTopDownUI()
//        initTimePickerView()
        self.view.addSubview(tableView)
        
        ZZDiskCacheHelper.getObj("userInfo") { (obj) in
            let  dic = obj! as!  [String : AnyObject]
            self.orgId =  dic["orgId"]! as? String
        }
        addRefreshView()
        headerRefreshView?.autoRefresh()
    }
    // Mark:创建ui
    func creatTopDownUI(){

        for item in titleArr {
            let index = titleArr.index(of: item)
            
            let nameLab = UILabel()
            nameLab.frame = CGRect(x: 10, y: 5+index!*40, width: 80, height: 30)
            nameLab.text = item
            nameLab.font = FontSize(14)
            nameLab.textAlignment = NSTextAlignment.left
            self.view.addSubview(nameLab)
            
            let textFiled = UITextField()
            textFiled.frame = CGRect(x: 90, y: 5+index!*40, width: Int(kScreenW-100), height: 30)
            textFiled.text = item
            textFiled.font = FontSize(14)
            textFiled.borderStyle = .line
            textFiled.delegate = self
            textFiled.tag = index!+100
            textFiled.layer.borderColor = HexRGBAlpha(0xcdcdcd,0.2).cgColor
            textFiled.textAlignment = NSTextAlignment.left
            self.view.addSubview(textFiled)
        }
        
        for item in leaveArr {
            let index = leaveArr.index(of: item)

            let nameLab = UILabel()
            nameLab.frame = CGRect(x: Int(kScreenW)-index!*60-60, y: titleArr.count*42, width: 60, height: 30)
            nameLab.text = item
            nameLab.font = FontSize(14)
            nameLab.textAlignment = NSTextAlignment.left
            self.view.addSubview(nameLab)
            
            let imgIco = UIImageView()
            imgIco.image = UIImage(named: imgIcoArr[index!])
            imgIco.frame = CGRect(x: Int(kScreenW)-index!*60-80, y: titleArr.count*42+7, width: 15, height:15)
            self.view.addSubview(imgIco)
        }
        
        
        let tabHeadView = UIView()
        tabHeadView.frame = CGRect(x:0 , y: titleArr.count*42+45, width: Int(kScreenW), height: 30)
        tabHeadView.backgroundColor = UIColor.purple
        self.view.addSubview(tabHeadView)
        for item in 0...3 {
            let nameLab = UILabel()
            nameLab.frame = CGRect(x: Int(CGFloat(item) * kScreenW/3), y: 0, width: Int(kScreenW/3), height: 30)
            nameLab.font = FontSize(14)
            nameLab.textColor = kWhite
            nameLab.textAlignment = NSTextAlignment.center
            tabHeadView.addSubview(nameLab)
            if item == 0{
                nameLab.text = "施工部位"

            }else if item == 1{
                nameLab.text = "出料时间"

            }else{
                nameLab.text = "砼等级"

            }
        }

        
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
        
        //        footerRefreshView = tableView.addFCXRefreshAutoFooter { [weak self] (refreshHeader) in
        //            print(refreshHeader)
        //            self?.loadMoreAction()
        //        }
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
    //请求组织机构数据
    func requestData(){
        
        let paramters : [String: String] = [
            "orgId":self.orgId ?? ""
        ]
        //        5921
        HTTP.GET(BaseUrl+uAPI_OrganizationList, parameters: paramters) { response in
            if let err = response.error {
                print("error: \(err.localizedDescription)")
                return
            }
            let responseData = JSON(response.data).arrayValue
            print(responseData.first ?? "")
            let  arr = responseData.first
            let mode = OrgMarkModel(jsonData: arr!)
            self.OrgMarkArr.add(mode)
            print(self.OrgMarkArr)
            self.SiteMachineList(tenderId: mode.orgid!)
            self.OrgMarkModels = self.OrgMarkArr.firstObject as! OrgMarkModel
            
        }
    }
    //获取拌合机列表
    func SiteMachineList(tenderId:String){
        
        let paramters : [String: String] = [
            "tenderId":tenderId
        ]
        //        5921
        HTTP.GET(BaseUrl+uAPI_SiteMachineList, parameters: paramters) { response in
            if let err = response.error {
                print("error: \(err.localizedDescription)")
                return
            }
            let responseData = JSON(response.data).arrayValue
            print(responseData)
            for dic in responseData{
                let  mode = MixerModel(jsonData: dic)
                self.MixerArr.add(mode)
            }
            
            self.MixerModels = self.MixerArr.firstObject as! MixerModel
            
        }
    }
    //施工部位
    func Search_WorkPart(tenderId:String,machineId:String){
        
        let paramters : [String: String] = [
            "tenderId":tenderId,
            "machineId":tenderId,
            "startDateStr":self.startTime ?? "",
            "endDateStr":self.endTime ?? ""

        ]
        HTTP.GET(BaseUrl+uAPI_Search_WorkPart, parameters: paramters) { response in
            if let err = response.error {
                print("error: \(err.localizedDescription)")
                return
            }
            let responseData = JSON(response.data).arrayValue
            print(responseData)
//            for dic in responseData{
//                let  mode = MixerModel(jsonData: dic)
//                self.MixerArr.add(mode)
//            }
            
        }
    }

}
extension MixingStationViewController:UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,PGDatePickerDelegate,AlertOrgListViewDeleget{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MixingStationCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "MixingStationCell")
        cell.backgroundColor = kWhite
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! MessageHeaderView
        return nil
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let datePickerManager = PGDatePickManager()
        datePickerManager.isShadeBackgroud = true
        let datePicker = datePickerManager.datePicker!
        datePicker.delegate = self
        datePicker.datePickerMode = .date
        

        self.alertView.backgroundColor = HexRGBAlpha(0xfafafa,1)
        self.alertView.layer.shadowColor = UIColor.gray.cgColor
        self.alertView.layer.shadowOffset = CGSize(width: -0, height: 3)
        self.alertView.layer.shadowRadius = 3
        self.alertView.layer.shadowOpacity = 0.8
        self.alertView.deleget = self
        switch textField.tag {
        case 100:
            let height = self.OrgMarkArr.count*35
            alertView.frame = CGRect(x: 90, y: 64+35, width: Int(kScreenW-100), height: height)
            self.alertView.showViewWidthDataArr(dataArr: self.OrgMarkArr, tableFrame: CGRect(x: 90, y: 74+64, width: Int(kScreenW-100), height: height))
            self.alertView.index = 1
        case 101:
            let height = self.MixerArr.count*35
            alertView.frame = CGRect(x: 90, y: 64+70, width: Int(kScreenW-100), height: height)
            self.alertView.showViewWidthDataArr(dataArr: self.MixerArr, tableFrame: CGRect(x: 80, y: 74+64, width: Int(kScreenW-100), height: height))
            alertView.index = 2
        case 102:
            self.present(datePickerManager, animated: false, completion: nil)
            self.ischange = "start"
        case 103:
            self.present(datePickerManager, animated: false, completion: nil)
            self.ischange = "end"

        default:
            break
        }
        return false
    }
    
  // MARK:  PGDatePickerDelegate
    func datePicker(_ datePicker: PGDatePicker!, didSelectDate dateComponents: DateComponents!) {
        print("dateComponents = ", dateComponents.year ?? "")

        
        if self.ischange == "start"{
            let  textfile = self.view.viewWithTag(102) as! UITextField
            textfile.text = "\(String(describing: dateComponents.year!))-\(String(describing: dateComponents.month!))-\(String(describing: dateComponents.day!))"
            self.startTime = "\(String(describing: dateComponents.year!))-\(String(describing: dateComponents.month!))-\(String(describing: dateComponents.day!))  \(String(describing: dateComponents.hour!)):\(String(describing: dateComponents.minute!)):\(String(describing: dateComponents.second!))"

        }else if self.ischange == "end"{
            let  textfile = self.view.viewWithTag(103) as! UITextField
            textfile.text = "\(String(describing: dateComponents.year!))-\(String(describing: dateComponents.month!))-\(String(describing: dateComponents.day!))"
            self.endTime = "\(String(describing: dateComponents.year!))-\(String(describing: dateComponents.month!))-\(String(describing: dateComponents.day!))  \(String(describing: dateComponents.hour!)):\(String(describing: dateComponents.minute!)):\(String(describing: dateComponents.second!))"
            
        }
        
         reloadData()

    }
    
    //选择了标段
    func cellClickCallback(model: Any, index: Int) {
        if index == 1 {
            self.OrgMarkModels = model as! OrgMarkModel
            let  textfile = self.view.viewWithTag(100) as! UITextField
            textfile.text = self.OrgMarkModels.name

        }else if index == 2{
            self.MixerModels = model as! MixerModel

            let  textfile = self.view.viewWithTag(101) as! UITextField
            textfile.text = self.MixerModels.name
        }
        
        reloadData()
    }
    
    //刷新数据
    func reloadData(){
        self.Search_WorkPart(tenderId: self.MixerModels.id!, machineId: self.OrgMarkModels.orgid!)

    }

}
