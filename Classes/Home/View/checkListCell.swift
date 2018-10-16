//
//  checkListCell.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/11.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit

class checkListCell: UITableViewCell {

    var unitLab = UILabel()
    var requirementsLab = UILabel()
    var unitTwoLab = UILabel()
    var peopleLab = UILabel()
    var timeLab = UILabel()
    
    var oneImg = UIImageView()
    var twoImg = UIImageView()
    var threeImg = UIImageView()
    var fourImg = UIImageView()
    
    var typeIco = UIImageView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        oneImg.image = UIImage(named: "safety_project_icon")
        self.contentView.addSubview(oneImg)
        
        twoImg.image = UIImage(named: "safety_content_check_icon")
        self.contentView.addSubview(twoImg)
        
        threeImg.image = UIImage(named: "safety_check_description_icon")
        self.contentView.addSubview(threeImg)
        
        fourImg.image = UIImage(named: "safety_people_icon")
        self.contentView.addSubview(fourImg)
        
        
        typeIco.image = UIImage(named: "safety_reply_icon")
        self.contentView.addSubview(typeIco)
        
        unitLab.text = "1"
        unitLab.font = FontSize(14)
        unitLab.textColor = UIColor.black
        unitLab.textAlignment = NSTextAlignment.left
        self.contentView.addSubview(unitLab)
        
        requirementsLab.text = "1"
        requirementsLab.font = FontSize(14)
        requirementsLab.textColor = UIColor.black
        requirementsLab.textAlignment = NSTextAlignment.left
        self.contentView.addSubview(requirementsLab)
        
        unitTwoLab.text = "1"
        unitTwoLab.font = FontSize(14)
        unitTwoLab.textColor = UIColor.black
        unitTwoLab.textAlignment = NSTextAlignment.left
        self.contentView.addSubview(unitTwoLab)
        
        peopleLab.text = "1"
        peopleLab.font = FontSize(14)
        peopleLab.textColor = UIColor.black
        peopleLab.textAlignment = NSTextAlignment.left
        self.contentView.addSubview(peopleLab)
        
        timeLab.text = "1"
        timeLab.font = FontSize(14)
        timeLab.textColor = UIColor.black
        timeLab.textAlignment = NSTextAlignment.right
        self.contentView.addSubview(timeLab)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        oneImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        
        twoImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(self.oneImg.snp.bottom).offset(10)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        
        threeImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(self.twoImg.snp.bottom).offset(10)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        
        fourImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(self.threeImg.snp.bottom).offset(10)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        
        unitLab.snp.makeConstraints { (make) in
            make.left.equalTo(oneImg.snp.right).offset(10)
            make.centerY.equalTo(oneImg)
        }
        requirementsLab.snp.makeConstraints { (make) in
            make.left.equalTo(unitLab.snp.left)
            make.centerY.equalTo(twoImg)
        }
        
        unitTwoLab.snp.makeConstraints { (make) in
            make.left.equalTo(unitLab.snp.left)
            make.centerY.equalTo(threeImg)
        }
        peopleLab.snp.makeConstraints { (make) in
            make.left.equalTo(unitLab.snp.left)
            make.centerY.equalTo(fourImg)
        }
        
        timeLab.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(fourImg)
        }
        
        typeIco.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.width.equalTo(54)
            make.height.equalTo(22)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func updataCellUI(model:checkListModel){
        
        self.unitLab.text = "受检单位：\(model.units ?? "")"
        self.requirementsLab.text = "整改要求：\(model.rectificationRequire ?? "")"
        self.timeLab.text = model.compleDateStr
        self.unitTwoLab.text = "整改单位：\(model.rectificationPersonStr ?? "")"
        self.peopleLab.text = "检查人"
    }
    
}
