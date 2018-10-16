//
//  MessageTopView.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/9/28.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
protocol MessageTopViewDeleget:NSObjectProtocol {
    func cllBack(index:NSInteger)
}
class MessageTopView: UIView {

    var selectBtn = UIButton()
    weak var delegate:MessageTopViewDeleget?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bgView = UIView()
        bgView.frame = CGRect(x: 15, y: 10, width: kScreenW-30, height: 40)
        bgView.backgroundColor = kWhite
        self.addSubview(bgView)
        bgView.makesLayerWithCornerRadius(cornerRadius: bgView.height/2, masksToBounds: true, borderWidth: 1, borderColor: HexRGBAlpha(0x0c84d2,1).cgColor)
        
        let titleArr:[String] = ["拌合站","预应力","压浆"]
        
        for item in titleArr {
            let btn = UIButton()
            let index:CGFloat = CGFloat(titleArr.index(of: item)!)
            btn.frame = CGRect(x: 0+index*(bgView.width/3), y: 0, width: bgView.width/3, height: bgView.height)
            btn.setTitle(item, for: UIControlState.normal)
            btn.tintColor = kWhite
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            bgView.addSubview(btn)
            
            btn.makesLayerWithCornerRadius(cornerRadius: btn.height/2, masksToBounds: true, borderWidth: 0, borderColor: HexRGBAlpha(0x0c84d2,1).cgColor)
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
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    
    
}
extension UIView{
    
    func makesLayerWithCornerRadius(cornerRadius:CGFloat,masksToBounds:Bool,borderWidth:CGFloat,borderColor:CGColor){
        self.layer.masksToBounds = masksToBounds
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
    }
}
