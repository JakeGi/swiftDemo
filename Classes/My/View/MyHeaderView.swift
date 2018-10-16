//
//  MyHeaderView.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/9/29.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit

class MyHeaderView: UITableViewHeaderFooterView {

    var userImg = UIImageView()
    var userName = UILabel()
    var bgImg = UIImageView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = HexRGBAlpha(0x0c84d2,1)
        userImg.image = UIImage(named: "user_default")?.toCircle()
        userImg.layer.masksToBounds = true
        userImg.layer.cornerRadius = 35
        self.contentView.addSubview(userImg)
        
        bgImg.image = UIImage(named: "setting_background_icon")
        self.contentView.addSubview(bgImg)
        
        userName.textColor = kWhite
        userName.font = FontSize(14)
        userName.text = "1"
        self.contentView .addSubview(userName)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgImg.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        userImg.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView.snp.centerY).offset(-10)
            make.centerX.equalTo(self.contentView)
            make.width.equalTo(70)
            make.height.equalTo(70)
        }
        
        userName.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.contentView)
            make.top.equalTo(userImg.snp.bottom).offset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updataUI(){
        
    }
    
}
//生成圆角
extension UIImage {
    //生成圆形图片
    func toCircle() -> UIImage {
        //取最短边长
        let shotest = min(self.size.width, self.size.height)
        //输出尺寸
        let outputRect = CGRect(x: 0, y: 0, width: shotest, height: shotest)
        //开始图片处理上下文（由于输出的图不会进行缩放，所以缩放因子等于屏幕的scale即可）
        UIGraphicsBeginImageContextWithOptions(outputRect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        //添加圆形裁剪区域
        context.addEllipse(in: outputRect)
        context.clip()
        //绘制图片
        self.draw(in: CGRect(x: (shotest-self.size.width)/2,
                             y: (shotest-self.size.height)/2,
                             width: self.size.width,
                             height: self.size.height))
        //获得处理后的图片
        let maskedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return maskedImage
    }
}
