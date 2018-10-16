//
//  MessageHeaderView.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/11.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit

class MessageHeaderView: UITableViewHeaderFooterView {

    var leftView = UIView()
    var titleLab = UILabel()
    var rightView = UIView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        leftView.backgroundColor = HexRGBAlpha(0x666666,1)
        self.contentView.addSubview(leftView)
        
        rightView.backgroundColor = HexRGBAlpha(0x666666,1)
        self.contentView.addSubview(rightView)
        
        titleLab.text = "未读消息0条"
        titleLab.font = FontSize(13)
        titleLab.textColor = HexRGBAlpha(0x666666,1)
        self.contentView .addSubview(titleLab)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //        cycleScrollView.delegate = self
        
        titleLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.contentView)
            make.centerY.equalTo(self.contentView)
        }
        leftView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(titleLab.snp.left).offset(-10)
            make.left.equalTo(self.contentView).offset(10)
            make.height.equalTo(1)
            
        }
        rightView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-10)
            make.left.equalTo(titleLab.snp.right).offset(10)
            make.height.equalTo(1)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
