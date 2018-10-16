//
//  HomeCollectionViewCell.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/9/28.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
     let nameLab = UILabel()
     let btnImg = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.clear
        nameLab.text = "1";
        nameLab.font = UIFont.systemFont(ofSize: 13)
        self.contentView.addSubview(nameLab)
        
        btnImg.image = UIImage(named: "wd_home_scan_01")
        self.contentView .addSubview(btnImg)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.contentView)
            make.centerY.equalTo(self.contentView).offset(20)
        }
        btnImg.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.contentView)
            make.centerY.equalTo(self.contentView).offset(-20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
