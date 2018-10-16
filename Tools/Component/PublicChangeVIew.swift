//
//  PublicChangeVIew.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/9/29.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit

class PublicChangeVIew: UIView {


    var titleArr:[String] = ["标段","标段2112","标段2112"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for item in titleArr {
            let index:CGFloat = CGFloat(titleArr.index(of: item)!)
            let TitleLab = UILabel()
            let TextFiled = UITextField()
            TitleLab.text = item
            TitleLab.textAlignment = NSTextAlignment.center
            self.addSubview(TitleLab)
            
            TextFiled.text = "1"
            self.addSubview(TextFiled)
            
            TitleLab.snp.makeConstraints { (make) in
                make.left.equalTo(self)
                make.height.equalTo(self)
                make.top.equalTo(self).offset(10*index*CGFloat(titleArr.count))
                make.width.equalTo(getLabelWidth(str: item, font: FontSize(14), height: 44)+10)

            }
            
            TextFiled.snp.makeConstraints { (make) in
                make.left.equalTo(TitleLab.snp.right).offset(10)
                make.right.equalTo(self)
                make.centerY.equalTo(TitleLab)
                make.height.equalTo(self)
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    func getLabelWidth(str: String, font: UIFont, height: CGFloat)->CGFloat {
     let statusLabelText:
     NSString = str as NSString
     let size = CGSize(width: CGFloat(MAXFLOAT), height: height)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil).size
          return strSize.width
    }
    
}
