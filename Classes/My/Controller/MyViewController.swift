//
//  MyViewController.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/9/27.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON
class MyViewController: PubBaseViewController {

    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: view.width, height: view.height - 64), style: UITableViewStyle.grouped)
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(MyHeaderView.classForCoder(), forHeaderFooterViewReuseIdentifier: "header")
        
        return tableView
    }()
    let nameArr:[String] = ["用户信息","当前版本","关于","帮助"]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)
        // Do any additional setup after loading the view.
    }
    //请求数据
    func requestData(){
        
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
                }
                //主线程刷新UI
                DispatchQueue.main.async(execute: {
                    
                    self.tableView.reloadData()
                    
                })
                
            }
        }
        
        
    }


}
extension MyViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = nameArr[indexPath.row] as String
        cell.textLabel?.font = FontSize(14)
        cell.textLabel?.textColor = HexRGBAlpha(0x666666,1)
        if indexPath.row != 1{
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator//添加箭头

        }
        return cell
    }
    //头部视图
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! MyHeaderView
            ZZDiskCacheHelper.getObj("userInfo") { (obj) in
                let  dic = obj! as!  [String : AnyObject]
                //主线程刷新UI
                DispatchQueue.main.async(execute: {
                    header.userName.text = dic["userName"] as? String
                    let url = URL(string:BaseUrl+uAPILoadImage+(dic["photo"] as? String)!)
                    header.userImg.kf.setImage(with:url)

                })
            }
        return header
        
    }
    //脚部试图
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       
        let footView = UIView()
        footView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 80)
        let outLoginBtn = UIButton()
        outLoginBtn.setTitle("退出登录", for: UIControlState.normal)
        outLoginBtn .addTarget(self, action:#selector(outLogin) , for: .touchUpInside)
        outLoginBtn.backgroundColor = HexRGBAlpha(kMainBlue,1)
        footView.addSubview(outLoginBtn)
        
        outLoginBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(footView)
            make.centerY.equalTo(footView)
            make.width.equalTo(kScreenW-40)
            make.height.equalTo(40)
        }
        
        return footView
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            let  vc = UserMessageViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            let  vc = AboutViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let  vc = HelpViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    @objc func outLogin(){
        print("触发退出登录")
        self.navigationController?.dismiss(animated: true, completion: {
            
        })
    }
}
