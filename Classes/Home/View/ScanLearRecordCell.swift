//
//  ScanLearRecordCell.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/10.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit

class ScanLearRecordCell: UITableViewCell {

    var theme = UILabel()
    var time = UILabel()
    var scrot = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        theme.text = "1"
        theme.font = FontSize(13)
        theme.textColor = HexRGBAlpha(0x666666,1)
        theme.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(theme)
        
        time.text = "1"
        time.font = FontSize(13)
        time.textColor = HexRGBAlpha(0x666666,1)
        time.numberOfLines = 2
        time.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(time)
        
        scrot.text = "1"
        scrot.font = FontSize(13)
        scrot.textColor = HexRGBAlpha(0x666666,1)
        scrot.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(scrot)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        theme.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.width.equalTo(kScreenW/3)
            make.left.equalTo(self.contentView)
        }
        time.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.width.equalTo(kScreenW/3)
            make.left.equalTo(self.theme.snp.right)
        }
        scrot.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.width.equalTo(kScreenW/3)
            make.left.equalTo(self.time.snp.right)

        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updataCellUI(mode:trainHistoryListModel){
        theme.text = mode.topic
        time.text = mode.trainDate
        if (mode.score != "") {
            scrot.text = mode.score

        }else{
            scrot.text = "暂无成绩"

        }
    }
}
