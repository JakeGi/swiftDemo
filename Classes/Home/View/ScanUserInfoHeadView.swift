//
//  ScanUserInfoHeadView.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/10.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit

class ScanUserInfoHeadView: UITableViewHeaderFooterView {

    var headImg = UIImageView()
    var headBg = UIImageView()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        headBg.image = UIImage(named: "setting_background_icon")
        self.contentView.addSubview(headBg)
        
        headImg.image = UIImage(named: "user_default")
        headImg.layer.masksToBounds = true
        headImg.layer.cornerRadius = 40
        self.contentView.addSubview(headImg)

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        headBg.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        headImg.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
