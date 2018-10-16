//
//  ZJTabBarController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/7/25.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAllViewController()
        
        //tabBar 底部工具栏背景颜色 (以下两个都行)
        //self.tabBar.barTintColor = UIColor.orange
        self.tabBar.backgroundColor = HexRGBAlpha(0xfbfafa,1)
        
        //设置 tabBar 工具栏字体颜色 (未选中  和  选中)
        
        // 设置图片和文字选中时的颜色   必须设置（系统默认选中蓝色）
        self.tabBar.tintColor = HexRGBAlpha(0x0c84d2,1)
//        self.tabBar.isTranslucent = false
        //去掉tabbar顶部黑线
        let TabBarLine = UITabBar.appearance()
        TabBarLine.shadowImage = UIImage()
        TabBarLine.backgroundImage = UIImage()
        
    }
    
    // 添加所有控件
    func setUpAllViewController() -> Void {
        setUpChildController(HomeViewController(), "首页","tabbar_01_n","tabbar_01_h")

        setUpChildController(MessageViewController(), "消息",  "tabbar_01_n",  "tabbar_01_h")
        setUpChildController(MyViewController(), "我的",  "tabbar_03_n",  "tabbar_03_h")
        
        //设置 tabBar 工具栏字体颜色 (未选中  和  选中)
    
        
    }
    
    // 设置子控件属性
    private func setUpChildController(_ controller : UIViewController,_ title : String,_ norImage : String,_ selectedImage : String){
        
        controller.tabBarItem.title = title
        // 修改TabBar标题位置
        controller.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3)
        controller.tabBarItem.image = UIImage(named: norImage)
        controller.tabBarItem.selectedImage = UIImage(named: selectedImage)
        // 设置 NavigationController
        let nav = ZJNavigationController(rootViewController: controller)
        controller.title = title
        self.addChildViewController(nav)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
