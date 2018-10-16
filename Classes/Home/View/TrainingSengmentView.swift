//
//  TrainingSengmentView.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/9/29.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
protocol TrainingSengmentViewDeleget:NSObjectProtocol {
    func cllBack(index:NSInteger)
}
class TrainingSengmentView: UIView {

    var selectBtn = UIButton()
    weak var delegate:TrainingSengmentViewDeleget?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        let bgView = UIView()
//        bgView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 40)
//        bgView.backgroundColor = kWhite
//        self.addSubview(bgView)
//        bgView.makesLayerWithCornerRadius(cornerRadius: bgView.height/2, masksToBounds: true, borderWidth: 1, borderColor: HexRGBAlpha(0x0c84d2,1).cgColor)
        
        let titleArr:[String] = ["未完成","已完成"]
        
        for item in titleArr {
            let btn = UIButton()
            let index:Int = Int(titleArr.index(of: item)!)
            btn.frame = CGRect(x: 0+index*(Int(kScreenW)/titleArr.count), y: 0, width: (Int(kScreenW)/titleArr.count), height:44)
            btn.setTitle(item, for: UIControlState.normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            self.addSubview(btn)
            
//            btn.makesLayerWithCornerRadius(cornerRadius: btn.height/2, masksToBounds: true, borderWidth: 0, borderColor: HexRGBAlpha(0x0c84d2,1).cgColor)
            btn.tag = Int(index + 100)
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
            
            
        }
    }
    @objc  func btnAction(sender:UIButton){
        if sender == self.selectBtn{
            return
        }
        self.selectBtn.isSelected = false
        sender.isSelected = true
        self.selectBtn = sender
        
        delegate?.cllBack(index: sender.tag)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
