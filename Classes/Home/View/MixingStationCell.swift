//
//  MixingStationCell.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/16.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit

class MixingStationCell: UITableViewCell {


    var nameLab = UILabel()
    var timeLab = UILabel()
    var leaveLab = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        nameLab.font = FontSize(14)
        nameLab.text = "--"
        nameLab.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(nameLab)
        
        timeLab.font = FontSize(14)
        timeLab.text = "--"
        timeLab.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(timeLab)
        
        leaveLab.font = FontSize(14)
        leaveLab.text = "--"
        leaveLab.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(leaveLab)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLab.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            
        }
        
        timeLab.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            
        }
        
        leaveLab.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            
        }
    }
    func updataCellUI() {
        
    }

}
