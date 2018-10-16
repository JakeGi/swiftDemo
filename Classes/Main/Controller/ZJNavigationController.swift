//
//  ZJNavigationController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/7/25.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
        
        // 自定义导航栏背景颜色
//        let navView = self.navigationBar.subviews.first
//        guard navView != nil else {return}
        // 导航栏背景渐变
//        zj_setUpGradientLayer(view: navView!, frame: CGRect(x: 0, y: 0, width: kScreenW, height: kStatuHeight+kNavigationBarHeight), color: [HexRGBAlpha(0x0c84d2,1)])
        

        
    }
    
    //MARK: 重写跳转
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.viewControllers.count>0 {
            
            viewController.hidesBottomBarWhenPushed = true //跳转之后隐藏
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem().barButtonItemWith(Target: self, Action: #selector(pressBack), NormalImage: UIImage(named:"wd_banner_back_2")!, HighLightedImage: UIImage(named:"wd_banner_back_2")!)
        }
        
        super.pushViewController(viewController, animated: true)
    }
    
    // 修改状态栏背景色为渐变色
    func setStatusBarBackgroundColor() {
        let statusBarWindow : UIView = UIApplication.shared.value(forKey: "statusBarWindow") as! UIView
        let statusBar : UIView = statusBarWindow.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {

        }
    }
    
    @objc func pressBack(){
        self.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension UIBarButtonItem {
    
    func barButtonItemWith(Target target:Any?, Action action:Selector?, NormalImage normalImage:UIImage?, HighLightedImage highLightImage:UIImage?) -> UIBarButtonItem{
        let btn = UIButton(type:.custom)
        if target != nil && action != nil {
            btn.addTarget(target, action: action!, for: .touchUpInside)
        }
        if normalImage != nil {
            btn.setBackgroundImage(normalImage, for: .normal)
        }
        if highLightImage != nil {
            btn.setBackgroundImage(highLightImage, for: .highlighted)
        }
        return UIBarButtonItem(customView: btn)
    }
    
}
