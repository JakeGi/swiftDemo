//
//  HomeViewController.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/9/27.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
import SBCycleScrollView
import Alamofire
import SwiftHTTP
class HomeViewController: PubBaseViewController,CycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {

     let imageUrls = ["https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3711690120,1162131576&fm=27&gp=0.jpg","https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1274844101,636774309&fm=27&gp=0.jpg","https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1185573334,16415454&fm=27&gp=0.jpg","https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2536078587,1520810066&fm=27&gp=0.jpg"]
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: view.width, height: view.height - 64), style: UITableViewStyle.grouped)
        tableView.register(HomeContentCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.register(HomeHeaderView.classForCoder(), forHeaderFooterViewReuseIdentifier: "header")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.tableFooterView = UIView()
        
        var tabBG = UIImageView()
        tabBG.frame = self.view.bounds
        tabBG.image = UIImage(named: "home_background")
        tableView.backgroundView = tabBG
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "西镇高速公路建设项目信息化管理平台"
        self.view.addSubview(tableView)
        
        NotificationCenter.default.addObserver(self, selector:  #selector(receiverNotification), name: NSNotification.Name(rawValue: NotiRefreshHomeItem), object: nil)

        requestData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //接受item点击事件
    @objc func receiverNotification(_ notification: Notification){
        
        guard let userInfo = notification.userInfo else {
            return
        }
        let index = userInfo[AnyHashable("index")] as! Int
        
        switch index {
        case 0:
            //二维码扫描
            let qrcodeVC = QrcodeViewController()
//            let qrcodeVC = ScanUserInfoViewController()

            self.navigationController?.pushViewController(qrcodeVC, animated: true)
            break
        case 1:
            //进场登记
            let InRegistrationVC = InRegistrationViewController()
            self.navigationController?.pushViewController(InRegistrationVC, animated: true)
            break
        case 2:
            //质量
            let QualityVC = QualityViewController()
            self.navigationController?.pushViewController(QualityVC, animated: true)
            break
        case 3:
            //安全
            let SafetyVC = SafetyViewController()
            self.navigationController?.pushViewController(SafetyVC, animated: true)
            break
        case 4:
            //公告通知
            let NoticeVC = NoticeViewController()
            self.navigationController?.pushViewController(NoticeVC, animated: true)
            break
        case 5:
            //新闻
            let NewsVC = NewsViewController()
            self.navigationController?.pushViewController(NewsVC, animated: true)
            break
        case 6:
            //培训
            let TrainingVC = TrainingViewController()
            self.navigationController?.pushViewController(TrainingVC, animated: true)
            break
        case 7:
            //随手拍
            let  TakePicturesVC = TakePicturesViewController()
            self.navigationController?.pushViewController(TakePicturesVC, animated: true)
            break
        case 8:
            //农民工
            let FarmersPayVC = FarmersPayViewController()
            self.navigationController?.pushViewController(FarmersPayVC, animated: true)
            break
        case 9:
            //拌合站
            let  MixingStationVC = MixingStationViewController()
            self.navigationController?.pushViewController(MixingStationVC, animated: true)
            break
        case 10:
            //预应力张拉
            let  PrestVC = PrestressedViewController()
            self.navigationController?.pushViewController(PrestVC, animated: true)
            break
        case 11:
            //压浆
            let GroutingVC = GroutingViewController()
            self.navigationController?.pushViewController(GroutingVC, animated: true)
            break
        default:
            break
        }
    }
    
    func requestData(){

        
        ZZDiskCacheHelper.getObj("userInfo") { (obj) -> () in
            print(obj)
        }
    
    
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

extension HomeViewController{
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
        return 150
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HomeContentCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
      cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header =   tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! HomeHeaderView
        header.cycleScrollView.imageURLStringsGroup = imageUrls
        header.bannerClickBlock = {(index) in
            print("controller-click\(index)")
           let vc =  HomeBannerDetailViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return header

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

