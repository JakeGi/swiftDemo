//
//  TrainingViewController.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/9/29.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
import SwiftFCXRefresh
class TrainingViewController: PubBaseViewController {

    var isOpen = false //是否打开
    let topchangeView = UIView()
    let sengmentView = TrainingSengmentView()
    let alertView = AlertOrgListView()
    var textfiled = UITextField()
    let arr:NSMutableArray = ["1","2"]

    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 74+40, width: view.width, height: view.height - 64-74-40), style: UITableViewStyle.grouped)
        tableView.register(TrainingCell.classForCoder(), forCellReuseIdentifier: "TrainingCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    var headerRefreshView: FCXRefreshHeaderView?
    var footerRefreshView: FCXRefreshFooterView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "培训列表"
        creatTopDownUI()
        self.view.addSubview(tableView)
        
    }
    //下拉刷新
    func addRefreshView() {
        headerRefreshView = tableView.addFCXRefreshHeader { (refreshHeader) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                
                refreshHeader.endRefresh()
                self.tableView.reloadData()
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
    func creatTopDownUI(){
        let downBtn = UIButton()
        downBtn.backgroundColor = HexRGBAlpha(0xdbdbdd,1)
        downBtn.setTitle("收起查询", for: .normal)
        downBtn.titleLabel?.font = FontSize(13)
        downBtn.setTitleColor(HexRGBAlpha(0x444444,1), for: .normal)
        downBtn.setImage(UIImage(named: "wd_top_up"), for: .normal)
        downBtn.hw_locationAdjust(buttonMode: .Left, spacing: 5)
        downBtn.addTarget(self, action: #selector(topDownBtn(sender:)), for: .touchUpInside)
        self.view.addSubview(downBtn)
        
        downBtn.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(30)
            make.top.equalTo(self.view)
        }
        
        self.view.addSubview(topchangeView)
        
        topchangeView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.top.equalTo(downBtn.snp.bottom)
            make.height.equalTo(44)
        }
        
        let nameLab = UILabel()
        nameLab.text = "标 段:"
        nameLab.font = FontSize(14)
        nameLab.textAlignment = NSTextAlignment.center
        topchangeView.addSubview(nameLab)
        
        nameLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(topchangeView)
            make.left.equalTo(topchangeView)
            make.width.equalTo(60)
        }
        
        let textfiled = UITextField()
        textfiled.placeholder = "请选择"
        textfiled.tag  = 100
        textfiled.delegate = self
        let rightview = UIImageView(image: UIImage(named: "tree_ex.png"))
        rightview.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        textfiled.rightViewMode = UITextFieldViewMode.always
        textfiled.font = FontSize(15)
        textfiled.rightView = rightview
        self.textfiled = textfiled
        
        topchangeView.addSubview(textfiled)
        textfiled.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLab)
            make.left.equalTo(nameLab.snp.right).offset(10)
            make.right.equalTo(topchangeView)
            make.height.equalTo(topchangeView)
        }
        sengmentView.delegate = self
        self.view.addSubview(sengmentView)
        sengmentView.snp.makeConstraints { (make) in
            make.top.equalTo(74)
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        let height = arr.count*35

        alertView.frame = CGRect(x: 80, y: 74+64, width: Int(kScreenW-100), height: height)

    }
    //点击展开收起选择项
    @objc func topDownBtn(sender:UIButton){
        isOpen = !isOpen
        print(isOpen)
        self.alertView.hideView()
        if isOpen == true{
            sender.setImage((UIImage(named: "down")), for: .normal)
            sender.setTitle("展开查询", for: .normal)
            topchangeView.isHidden = true
            sengmentView.snp.updateConstraints { (make) in
                make.top.equalTo(self.view).offset(30)
                make.width.equalToSuperview()
                make.height.equalTo(40)
            }
            tableView.snp.updateConstraints { (make) in
                make.top.equalTo(self.view).offset(30+40)
                make.width.equalTo(kScreenW)
                make.height.equalTo(kScreenH-64-40)
            }

        }else{
            sender.setImage((UIImage(named: "wd_top_up")), for: .normal)
            sender.setTitle("收起查询", for: .normal)
            topchangeView.isHidden = false
            
   
            sengmentView.snp.updateConstraints { (make) in
                make.top.equalTo(self.view).offset(74)
                make.width.equalToSuperview()
                make.height.equalTo(40)
            }
            tableView.snp.updateConstraints { (make) in
                make.top.equalTo(self.view).offset(74+40)
                make.width.equalTo(kScreenW)
                make.height.equalTo(kScreenH-64-74-40)
            }
            
        }
    }

}
extension TrainingViewController:UITableViewDelegate,UITableViewDataSource,TrainingSengmentViewDeleget,UITextFieldDelegate,AlertOrgListViewDeleget{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TrainingCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "TrainingCell")
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator//添加箭头

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
    
    func cllBack(index: NSInteger) {
        print(index)
        self.headerRefreshView?.autoRefresh()
    }
    
    //输入框代理
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 100{
            let height = arr.count*35
            self.alertView.showViewWidthDataArr(dataArr: self.arr, tableFrame: CGRect(x: 80, y: 74+64, width: Int(kScreenW-100), height: height))
            self.alertView.backgroundColor = HexRGBAlpha(0xfafafa,1)
            self.alertView.layer.shadowColor = UIColor.gray.cgColor
            self.alertView.layer.shadowOffset = CGSize(width: -0, height: 3)
            self.alertView.layer.shadowRadius = 3
            self.alertView.layer.shadowOpacity = 0.8
            self.alertView.deleget = self
            return false
        }else{
            return true;
        }
    }
    
    
    func cellClickCallback(model: Any, index: Int) {
        print((model as AnyObject).name ?? "")

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alertView.hideView()
        print("111111111")
    }
}
