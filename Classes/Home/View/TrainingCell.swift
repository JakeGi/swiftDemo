//
//  TrainingCell.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/9/29.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit

class TrainingCell: UITableViewCell {

    var themeVul = UILabel()
    var addresVul = UILabel()
    var statusVul = UILabel()
    var founderVul = UILabel()
    var timeVul = UILabel()
    let titleArr:[String] = ["主题:","地点:","状态:","创建人:","时间:"]
    let imgArr:[String]=["train_theme_icon","train_location_icon","train_state_icon","safety_people_icon","train_time_icon"]

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        
        for item in titleArr {
            let index = titleArr.index(of: item)
            
            let itemView = UIView()
            itemView.frame = CGRect(x: 0, y:  5+index!*30, width: Int(kScreenW), height: 30)
            self.contentView.addSubview(itemView)
            
            let leftImg = UIImageView()
            leftImg.frame = CGRect(x: 20, y: (30 - 20)/2 - 2, width: 20, height: 20)
            leftImg.image = UIImage(named:imgArr[index!])
            itemView.addSubview(leftImg)
            
            let titleLab = UILabel()
            titleLab.frame = CGRect(x: 50, y: (30 - 18)/2 - 2, width: 50, height: 18)
            titleLab.textAlignment = NSTextAlignment.left
            titleLab.font = FontSize(14)
            titleLab.text = item
            itemView.addSubview(titleLab)
            
            let valueLab = UILabel()
            valueLab.frame = CGRect(x: 100, y: (30 - 18)/2 - 2, width: Int(kScreenW)-95-80, height: 18)

            valueLab.textAlignment = NSTextAlignment.left
            valueLab.font = FontSize(14)
            valueLab.text = "1"
            itemView.addSubview(valueLab)
            
            if index == 0{
                themeVul = valueLab
            }else if index == 1{
                addresVul = valueLab
            }else if index == 2{
                statusVul = valueLab
            }else if index == 3{
                founderVul = valueLab
            }else{
                timeVul = valueLab
            }
 
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
