//
//  ScanUserInfoCell.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/10.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit

class ScanUserInfoCell: UITableViewCell {

    var leftName = UILabel()
    var rightValue = UILabel()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        leftName.font = FontSize(16)
        leftName.textColor = HexRGBAlpha(0x383838,1)
        leftName.textAlignment = NSTextAlignment.left
        self.contentView.addSubview(leftName)
        
        rightValue.font = FontSize(14)
        rightValue.textColor = HexRGBAlpha(0x6a6a6a,1)
        rightValue.textAlignment = NSTextAlignment.right
        self.contentView.addSubview(rightValue)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        leftName.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(80)
        }
        rightValue.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.left.equalTo(self.leftName.snp.right).offset(10)
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updataCellUI(mode:userInfoMode,indexPath:IndexPath,nameArr:[String]){
        
        self.leftName.text = nameArr[indexPath.row]
        switch indexPath.row {
        case 0:
            self.rightValue.text = mode.name
            break;
        case 1:
            self.rightValue.text = String(stringInterpolationSegment: mode.age!)
            break;

        case 2:
            if mode.sex == 0{
                self.rightValue.text = "女"

            }else{
                self.rightValue.text = "男"

            }
            break;

        case 3:
            self.rightValue.text = mode.jobNo
            break;

        case 4:
            self.rightValue.text = mode.nativePlace
            self.rightValue.numberOfLines = 2
            break;

        case 5:
            self.rightValue.text = mode.enterTime
            break;
        case 6:
            self.rightValue.text = mode.idCardNo
            break;
        case 7:
            self.rightValue.text = mode.workTypeStr
            break;

        case 8:
            if mode.jobType == 0{
                self.rightValue.text = "组员"
                
            }else{
                self.rightValue.text = "组长"
                
            }
            break;
        case 9:
            self.rightValue.text = mode.teamStr
            break;
        case 10:
            if mode.type == 0{
                self.rightValue.text = "在场"

            }else{
                self.rightValue.text = "离场"

            }
            break;
        default:
            break;
        }
    }
    
}
