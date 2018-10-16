//
//  AlertOrgListView.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/12.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
protocol AlertOrgListViewDeleget {
    func cellClickCallback(model:Any,index:Int)
}
class AlertOrgListView: UIView {

    var tableview = UITableView()
    let backView = UIView()
    var dataArr:NSMutableArray = []
    var deleget:AlertOrgListViewDeleget?
    var index:Int?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSubUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //创建子控件
    func initSubUI(){
        
        self.backgroundColor = UIColor.brown
        let MskeBtn = UIButton()
        MskeBtn.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH)
        MskeBtn.addTarget(self, action: #selector(btnAction), for: UIControlEvents.touchUpInside)
        self.addSubview(MskeBtn)
        
        self.backView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1)
        self.backView.backgroundColor = HexRGBAlpha(0xfafafa,1)
        self.backView.layer.shadowColor = UIColor.gray.cgColor
        self.backView.layer.shadowOffset = CGSize(width: -0, height: 3)
        self.backView.layer.shadowRadius = 3
        self.backView.layer.shadowOpacity = 0.8
        self.addSubview(self.backView)
        
        let table = UITableView.init(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1), style: .plain)
        table.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        table.bounces = false
        table.delegate = self
        table.dataSource = self
        self.addSubview(table)
        self.tableview = table
    }
    
    //点击view消失
    @objc func btnAction(){
        
        self.hideView()
    }
    
    func hideView(){
        self.alpha = 1
        self.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            
        }) { (finished) in
            self.isHidden = true
            self.removeFromSuperview()
        }
    }
    func showView(){
        let originalKeyWindow = UIApplication.shared.delegate?.window
        originalKeyWindow??.addSubview(self)
        
        self.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 1
        }) { (finish) in
            
        }
    }
    
    func showViewWidthDataArr(dataArr:NSMutableArray,tableFrame:CGRect){
        
        self.dataArr.removeAllObjects()
        for mode in dataArr{
            self.dataArr.add(mode)
        }
        var height = 10 +  dataArr.count*35
        if height > Int(frame.size.height){
            height = Int(frame.size.height)
        }
        var tepFrame = CGRect()
        tepFrame.size.height = 1
        tepFrame.size.width = self.frame.size.width
        self.tableview.frame = tepFrame
        
        self.showView()
        //主线程刷新UI
        self.tableview.reloadData()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.tableview.width = self.frame.size.width
            self.tableview.height = CGFloat(height)

            self.backView.height = CGFloat(height)
        }) { (finish) in
        
        }


    }
}

extension AlertOrgListView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.dataArr.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
//        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator//添加箭头
        if index == 1{
            let model =  self.dataArr[indexPath.row] as! OrgMarkModel
            cell.textLabel?.text = model.name


        }else if index == 2{
            let model =  self.dataArr[indexPath.row] as! MixerModel
            cell.textLabel?.text = model.name

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! MessageHeadView
        return nil
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if index == 1 {
            deleget?.cellClickCallback(model: self.dataArr[indexPath.row] as! OrgMarkModel as AnyObject,index:self.index!)

        }else if index == 2{
            deleget?.cellClickCallback(model: self.dataArr[indexPath.row] as! MixerModel as AnyObject,index:self.index!)

        }
        self.hideView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
}
