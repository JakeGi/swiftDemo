//
//  PubBaseViewController.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/9/27.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SwiftHTTP

class PubBaseViewController: UIViewController {

//     let logingView = NVActivityIndicatorView()
     var logingView = NVActivityIndicatorView(frame: CGRect(x: kScreenW/2-30, y: kScreenH/2-30, width: 60, height: 60), type: .ballPulse, color: UIColor.blue, padding: 10)
    // 状态栏的背景色
    lazy var  statuView : UIView = {
        let view = UIView()
        view.backgroundColor = kMainOrangeColor;
        view.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kStatuHeight)
        // 设置背景渐变
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = kGradientColors
        //(这里的起始和终止位置就是按照坐标系,四个角分别是左上(0,0),左下(0,1),右上(1,0),右下(1,1))
        //渲染的起始位置
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        //渲染的终止位置
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
        //设置frame和插入view的layer
        gradientLayer.frame = view.frame
        view.layer.insertSublayer(gradientLayer, at: 0)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kWhite
        self.navigationController?.navigationBar.barTintColor = HexRGBAlpha(0x0c84d2,1)
        let dict:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)]
        //标题颜色
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey : AnyObject]
    
    }
    

    // 配置 NavigationBar
    func setUpNavigation(){
        // 修改状态栏背景颜色
        self.navigationController?.navigationBar.barTintColor = kMainOrangeColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        // 左边的按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "btn_user_normal"), style:.done ,target: self, action: #selector(self.leftItemClick))
        // 右边的按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "viewHistoryIcon"), style:.done, target: self, action: #selector(self.rightItemClick)) //UIBarButtonItem.createBarButton("search_history", "search_history", size)
        
    }
    
    @objc func rightItemClick() {
        //        print("rightItem click")
        //        self.navigationController?.pushViewController(ZJHistoryRecordViewController(), animated: true)
    }
    
    @objc func leftItemClick() {
//        self.navigationController?.pushViewController(ZJProfileViewController(), animated: true)
//        print("leftItem Click")
    }
    
    deinit {
        
    }

}
