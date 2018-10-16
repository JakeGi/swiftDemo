//
//  NoticeCell.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/9/29.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit

class NoticeCell: UITableViewCell {

    //标题
    let titleLabel = UILabel()
    //发文字号
    let issuedNoLabel = UILabel()
    //内容
    let contentLabel = UILabel()
    //创建者
    let createrLabel = UILabel()
    //时间
    let timeLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLabel.text = "标题:西镇高速";
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(titleLabel)
        
        issuedNoLabel.text = "发文字号:PD——";
        issuedNoLabel.font = UIFont.systemFont(ofSize: 14)
        issuedNoLabel.textColor = HexRGBAlpha(0x666666,1)
        self.contentView.addSubview(issuedNoLabel)
        
    
        contentLabel.text = "西镇高速";
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.textColor = HexRGBAlpha(0x666666,1)

        self.contentView.addSubview(contentLabel)
        
        
        createrLabel.text = "创建人:西镇高速";
        createrLabel.textColor = HexRGBAlpha(0x666666,1)

        createrLabel.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(createrLabel)
        
        timeLabel.text = "2019-01-11";
        timeLabel.textColor = HexRGBAlpha(0x666666,1)
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(timeLabel)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(20)
            make.right.equalTo(self.contentView.snp.right).offset(-20)
            make.top.equalTo(self.contentView).offset(20)
        }
        
        issuedNoLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.left)
            make.right.equalTo(self.contentView.snp.right).offset(-20)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.left)
            make.right.equalTo(self.contentView.snp.right).offset(-20)
            make.top.equalTo(self.issuedNoLabel.snp.bottom).offset(10)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-10)
            make.top.equalTo(self.contentLabel.snp.bottom).offset(10)
        }
        createrLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.left)
            make.right.equalTo(self.timeLabel.snp.left).offset(-10)
            make.top.equalTo(self.contentLabel.snp.bottom).offset(10)
        }

    }
    //cell赋值
    func showListData(mode:NoticeModel){
        self.titleLabel.text = "标题:\(mode.title!)"
        self.issuedNoLabel.text = "发文字号:\(mode.issuedNo!)"
        self.contentLabel.text = mode.content
        self.createrLabel.text = "创建人: \(mode.createUserName!)"
        self.timeLabel.text = mode.createTime
    }

}

