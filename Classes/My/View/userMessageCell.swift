//
//  userMessageCell.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/15.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit

class userMessageCell: UITableViewCell {


    var leftName = UILabel()
    var rightLab = UILabel()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        leftName.text = ""
        leftName.font = FontSize(16)
        leftName.textColor = HexRGBAlpha(0x383838,1)
        leftName.textAlignment = NSTextAlignment.left
        self.contentView.addSubview(leftName)
        
        rightLab.text = ""
        rightLab.font = FontSize(16)
        rightLab.textColor = HexRGBAlpha(0x383838,1)
        rightLab.textAlignment = NSTextAlignment.right
        self.contentView.addSubview(rightLab)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        leftName.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.contentView).offset(15)
        }
        rightLab.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(self.contentView).offset(-15)
        }
    }
    
    func updataCellUI(dataArr:NSMutableArray,indexPath:IndexPath){
        
        switch indexPath.row {
        case 0:
            self.leftName.text = "用户名"
            self.rightLab.text = dataArr[indexPath.row] as? String
        case 1:
            self.leftName.text = "部门"
            self.rightLab.text = dataArr[indexPath.row] as? String
        case 2:
            self.leftName.text = "修改密码"
            self.rightLab.text = dataArr[indexPath.row] as? String
            self.accessoryType = UITableViewCellAccessoryType.disclosureIndicator//添加箭头

        default:
            break
        }
    }

}
