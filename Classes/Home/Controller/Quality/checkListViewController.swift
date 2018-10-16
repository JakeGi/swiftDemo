//
//  checkListViewController.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/11.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON
import SwiftFCXRefresh


class checkListViewController: PubBaseViewController {

    var searchControler:UISearchController!
    var selectBtn = UIButton()
    var type:String = "1"
    var userID:String?
    var navTitle:String?
    var listDataArr:NSMutableArray = []
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 100, width: view.width, height: view.height - 64-100), style: UITableViewStyle.grouped)
        tableView.register(checkListCell.classForCoder(), forCellReuseIdentifier: "checkListCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var headerRefreshView: FCXRefreshHeaderView?
    var footerRefreshView: FCXRefreshFooterView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.navTitle
        initSubView()
        ZZDiskCacheHelper.getObj("userInfo") { (obj) in
            let  dic = obj! as!  [String : AnyObject]
            self.userID =  dic["userId"]! as? String
        }
        
        addRefreshView()
        headerRefreshView?.autoRefresh()
    }

    
    func initSubView(){
        self.searchControler = UISearchController(searchResultsController: nil)
        self.searchControler.searchBar.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 44)
        self.searchControler.searchResultsUpdater = self
        self.searchControler.dimsBackgroundDuringPresentation = false
        self.searchControler.searchBar.placeholder = "按照整改单位查询"
        self.searchControler.searchBar.delegate = self
        self.searchControler.searchBar.sizeToFit()
        self.searchControler.definesPresentationContext = true
        self.searchControler.hidesNavigationBarDuringPresentation = false
        self.view.addSubview(self.searchControler.searchBar)
        
        //创建头部切换菜单
        var titleArr:[String] = []
        if self.navTitle ==  "质量检查" {
            titleArr = ["我收到的","抄送我的"]

        }else if self.navTitle == "质量整改"{
            
            titleArr = ["我收到的","抄送我的"]

        }else if self.navTitle == "安全检查"{
            
               titleArr = ["我收到的","我监督的"]
            
        }else if self.navTitle == "安全整改"{
            
            titleArr = ["我收到的","抄送我的","我监督的"]
        }
        for item in titleArr {
            
            let index:Int = Int(titleArr.index(of: item)!)
            let btn = UIButton()
            btn.frame = CGRect(x: 0+index*(Int(kScreenW)/titleArr.count), y: 56, width: Int(kScreenW)/titleArr.count, height:44)
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
        //创建列表
        
        self.view.addSubview(self.tableView)
    }

    
    @objc func btnAction(sender:UIButton){
        print(sender.tag)
        self.type = String(sender.tag)
        if sender == self.selectBtn{
            return
        }
        self.selectBtn.isSelected = false
        sender.isSelected = true
        self.selectBtn = sender
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
    //请求数据
    func requestData(){
        
        self.listDataArr.removeAllObjects()
        let paramters : [String: String] = [
            "sheetType":"2",
            "userId":"5921"
            ]
//        5921
        HTTP.GET(BaseUrl+uAPI_Quality_UpdateList, parameters: paramters) { response in
            if let err = response.error {
                print("error: \(err.localizedDescription)")
                return
            }
            let newsData = JSON(response.data).arrayValue

            print(newsData)
            for dic in newsData{
                let mode = checkListModel(jsonData: dic)
                
                self.listDataArr.add(mode)
            }
            
            //主线程刷新UI
            DispatchQueue.main.async(execute: {
                
                self.tableView.reloadData()
                
            })
            
        }
        
        
    }

}
extension checkListViewController:UISearchBarDelegate,UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource{
    
    //开始进行文本编辑，设置显示搜索结果，刷新列表

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    //点击Cancel按钮，设置不显示搜索结果并刷新列表

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    //点击搜索按钮，触发该代理方法，如果已经显示搜索结果，那么直接去除键盘，否则刷新列表

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    //这个updateSearchResultsForSearchController(_:)方法是UISearchResultsUpdating中唯一一个我们必须实现的方法。当search bar 成为第一响应者，或者search bar中的内容被改变将触发该方法.不管用户输入还是删除search bar的text，UISearchController都会被通知到并执行上述方法。
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        print(searchString)
            //过滤数据源，存储匹配的数据
//        filteredArray = dataArray.filter({ (country) -> Bool in
//            let countryText: NSString = country as NSString
//            return   (countryText.range(of: searchString!, options: .caseInsensitive).location) != NSNotFound
//
//        })
        //刷新表格
//        tableView.reloadData()
        

    }
    
    //tableview代理方法
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listDataArr.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = checkListCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "checkListCell")
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator//添加箭头
        cell.updataCellUI(model: self.listDataArr[indexPath.row] as! checkListModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! MessageHeadView
        return nil
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let mode = self.listDataArr[indexPath.row] as! newsModel
//        let vc = newDetailViewController()
//        vc.inittWithTitle(title: mode.title!, urlStr: mode.url!)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
}
