//
//  NewsViewController.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/9/29.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
import SwiftFCXRefresh
import SwiftyJSON
import SwiftHTTP

class NewsViewController: PubBaseViewController {

    var selectBtn = UIButton()
    var newsType:String = "1"
    var listDataArr:NSMutableArray = []

    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 44, width: view.width, height: view.height - 64), style: UITableViewStyle.grouped)
        tableView.register(NewsCell.classForCoder(), forCellReuseIdentifier: "NewsCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    var headerRefreshView: FCXRefreshHeaderView?
    var footerRefreshView: FCXRefreshFooterView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "新闻"
        creatTopView()
        self.view.addSubview(tableView)
        addRefreshView()
        headerRefreshView?.autoRefresh()

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
    //创建头部切换菜单
    private func creatTopView(){
        
        let titleArr:[String] = ["工作简报","专题简报","会议简报","工地文化"]
        for item in titleArr {
            
            let index:CGFloat = CGFloat(titleArr.index(of: item)!)
            let btn = UIButton()
            btn.frame = CGRect(x: 0+index*(kScreenW/4), y: 0, width: kScreenW/4, height:44)
            btn.setTitle(item, for: .normal)
            btn.tag = Int(index + 1)
            btn.titleLabel?.font = FontSize(15)
            btn.addTarget(self, action: #selector(self.btnAction(sender:)), for: UIControlEvents.touchUpInside)
            btn.setBackgroundImage(createImageFrom(Color: HexRGBAlpha(0x0c84d2,1)), for: UIControlState.highlighted)
            btn.setBackgroundImage(createImageFrom(Color: HexRGBAlpha(0x0c84d2,1)), for: UIControlState.selected)
            btn.setTitleColor(UIColor.black, for: UIControlState.normal)
            btn.setTitleColor(UIColor.white, for: UIControlState.highlighted)
            btn.setTitleColor(UIColor.white, for: UIControlState.selected)
            if index == 0 {
                btn.isSelected = true
                self.selectBtn = btn
            }
            self.view.addSubview(btn)
        }
        
    }
    
    @objc func btnAction(sender:UIButton){
        print(sender.tag)
        self.newsType = String(sender.tag)
        if sender == self.selectBtn{
            return
        }
        self.selectBtn.isSelected = false
        sender.isSelected = true
        self.selectBtn = sender
        headerRefreshView?.autoRefresh()
    }

    //请求数据
    func requestData(){
 
        self.listDataArr.removeAllObjects()
        let paramters : [String: String] = [
            "newsType":self.newsType,
            ]
        
        HTTP.GET(BaseUrl+uAPI_News_NewsPage, parameters: paramters) { response in
            if let err = response.error {
                print("error: \(err.localizedDescription)")
                return //also notify app of failure as needed
            }
            let newsData = JSON(response.data).arrayValue
            print(newsData)
            for dic in newsData{
                let mode = newsModel(jsonData: dic)
                
                self.listDataArr.add(mode)
            }
            //主线程刷新UI
            DispatchQueue.main.async(execute: {
                
                self.tableView.reloadData()

            })
            
        }
        
        
    }

}

extension NewsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listDataArr.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NewsCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "NewsCell")
        let mode = self.listDataArr[indexPath.row] as! newsModel
        cell.updataCellUI(model: mode)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! MessageHeadView
        return nil
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let mode = self.listDataArr[indexPath.row] as! newsModel
        let vc = newDetailViewController()
        vc.inittWithTitle(title: mode.title!, urlStr: mode.url!)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
}
