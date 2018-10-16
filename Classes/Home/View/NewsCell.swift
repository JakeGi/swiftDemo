//
//  NewsCell.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/9/29.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    //图片
    let listImg = UIImageView()
    //标题
    let listTitle = UILabel()
    //内容
    let listContent = UILabel()
    //时间
    let listTime = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        listImg.image = UIImage(named: "wd_home_scan_11_2")
        self.contentView.addSubview(listImg)
        
        listTitle.text = "init(coder:) has not been implemented"
        listTitle.font = FontSize(15)
        listTitle.numberOfLines = 2
        listTitle.textAlignment = NSTextAlignment.left
        self.contentView.addSubview(listTitle)
        
        listContent.text = "init(coder:) has not been implemented"
        listContent.numberOfLines = 2
        listContent.font = FontSize(13)
        listContent.textColor = HexRGBAlpha(kMainGray,1)
        listContent.textAlignment = NSTextAlignment.left
        self.contentView.addSubview(listContent)
        
        listTime.text = "2019-09-22 09:11:11"
        listTime.font = FontSize(13)
        listTime.textColor = HexRGBAlpha(kMainGray,1)
        listTime.textAlignment = NSTextAlignment.right
        self.contentView.addSubview(listTime)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        listImg.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.top.equalTo(self.contentView).offset(10)
            make.bottom.equalTo(self.contentView).offset(-10)
            make.width.equalTo(kScreenW/3)
        }
        listTitle.snp.makeConstraints { (make) in
            make.top.equalTo(listImg.snp.top)
            make.left.equalTo(listImg.snp.right).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
        }
        
        listContent.snp.makeConstraints { (make) in
            make.top.equalTo(listTitle.snp.bottom).offset(10)
            make.left.equalTo(listImg.snp.right).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
        }
        
        listTime.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView).offset(-10)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
    }
    
    //更新UI
    func updataCellUI(model:newsModel){
        let url = URL(string: model.titlePicUrl!)
        self.listImg.kf.setImage(with:url)
        self.listTitle.text = model.title
        self.listContent.text = model.subtitle
        self.listTime.text = model.createTime
    }

}
