//
//  ScanLearRecordHeadView.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/10.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit

class ScanLearRecordHeadView: UITableViewHeaderFooterView {


    var titleLab = UILabel()
    var dataArr:[String] = ["姓名","签到时间","考试成绩"]
    var titleView = UIView()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        titleLab.textColor = HexRGBAlpha(0x333333,1)
        titleLab.font = FontSize(16)
        titleLab.text = "培训记录"
        self.contentView.addSubview(titleLab)
        
        titleView.backgroundColor = HexRGBAlpha(0x21b9fa,1)
        self.contentView.addSubview(titleView)
        
        for item in dataArr {
            let index:Int = Int(dataArr.index(of: item)!)

            let lab = UILabel()
//            lab.frame = CGRect(x: 2+index*Int(kScreenW)/dataArr.count, y: Int(titleLab.frame.size.height)+10, width: Int(kScreenW)/dataArr.count-4, height: 20)
            lab.text = item
            lab.font = FontSize(15)
            lab.textColor = kWhite
            lab.textAlignment = NSTextAlignment.center
            self.titleView.addSubview(lab)
            
            lab.snp.makeConstraints { (make) in
                make.centerY.equalTo(titleView)
                make.left.equalTo(index*Int(kScreenW)/dataArr.count)
                make.width.equalTo(Int(kScreenW)/dataArr.count)
                make.height.equalTo(20)
            }
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(20)
            make.top.equalTo(self.contentView).offset(-10)
            make.height.equalTo(30)
        }
        titleView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(self.titleLab.snp.bottom).offset(5)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
