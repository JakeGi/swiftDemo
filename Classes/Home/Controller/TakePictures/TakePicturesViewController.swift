//
//  TakePicturesViewController.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/9/29.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON
import SwiftFCXRefresh
import ImagePicker
class TakePicturesViewController: PubBaseViewController {
    
    var searchControler:UISearchController!
    var listDataArr:NSMutableArray = []
    var imgArr:NSMutableArray = []

    var userID:String?
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 56, width: kScreenW, height: kScreenH-64-20), style: UITableViewStyle.grouped)
        tableView.register(TakePicCell.classForCoder(), forCellReuseIdentifier: "TakePicCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var headerRefreshView: FCXRefreshHeaderView?
    var footerRefreshView: FCXRefreshFooterView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "随手拍"
        // Do any additional setup after loading the view.
        ZZDiskCacheHelper.getObj("userInfo") { (obj) in
            let  dic = obj! as!  [String : AnyObject]
            self.userID =  dic["userId"]! as? String
        }
        initSubView()
        addRefreshView()
        headerRefreshView?.autoRefresh()
    }
    
    func initSubView(){

        let button = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "wd_banner_camera"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(rightActionClick), for: UIControlEvents.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
        
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
        
        self.view.addSubview(self.tableView)
    }
    
    @objc func rightActionClick(){
        print("点击了")
//        let imagePickerController = ImagePickerController()
  
        let configuration = Configuration()
        configuration.doneButtonTitle = "确定"
        configuration.noImagesTitle = "Sorry! There are no images here!"
        configuration.recordLocation = false
        
        let imagePicker = ImagePickerController(configuration: configuration)
        imagePicker.delegate = self
//        imagePicker.imageLimit = 5  //最多选几张
        present(imagePicker, animated: true, completion: nil)
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
    //请求数据
    func requestData(){
        
        self.listDataArr.removeAllObjects()
        let paramters : [String: String] = [
            "userId":self.userID ?? ""
        ]
        //        5921
        HTTP.GET(BaseUrl+uAPI_TakePic_showList, parameters: paramters) { response in
            if let err = response.error {
                print("error: \(err.localizedDescription)")
                return
            }
            let newsData = JSON(response.data).arrayValue
            let imgData = JSON(response.data)["picsList"].arrayValue

//            print(newsData)
            for dic in newsData{
                let mode = TakePicturesModel(jsonData: dic)
                self.listDataArr.add(mode)
            }


            //主线程刷新UI
            DispatchQueue.main.async(execute: {
                
                self.tableView.reloadData()
                
            })
            
        }
        
        
    }
}
extension TakePicturesViewController:UISearchBarDelegate,UISearchResultsUpdating,UITableViewDelegate,
UITableViewDataSource,ImagePickerDelegate{
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
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listDataArr.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TakePicCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "TakePicCell")
//        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator//添加箭头
        cell.updataCellUI(model: self.listDataArr[indexPath.row] as! TakePicturesModel)
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
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        print(images)
    }
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        print(images)
        imagePicker.dismiss(animated: true) {
            
        }

    }
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        print("cancel")
        imagePicker.dismiss(animated: true) {
            
        }
    }
}
