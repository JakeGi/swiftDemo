//
//  TakePicCell.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/11.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit

class TakePicCell: UITableViewCell {

    var titleArr:[String] = ["标题:","发布人:","位置:","时间:","谁可以看:"]
    var leftImg = UIImageView()
    var rightOneLab = UILabel()
    var righttwoLab = UILabel()
    var rightthreeLab = UILabel()
    var rightfourLab = UILabel()
    var rightfiveLab = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        leftImg.image = UIImage(named: "user_default")
        self.contentView.addSubview(leftImg)
        let left = 120
        for item in titleArr {
            let index:Int = Int(titleArr.index(of: item)!)
            let lab = UILabel()
            lab.frame = CGRect(x: left, y: 15+index*25, width: 70, height: 20)
            lab.textColor = HexRGBAlpha(0x666666,1)
            lab.font = FontSize(14)
            lab.text = item
            lab.textAlignment = NSTextAlignment.left
            self.contentView.addSubview(lab)
            
            let valueLab = UILabel()
            valueLab.frame = CGRect(x: left+75, y: 15+index*25, width: Int(kScreenW)-left-80, height: 20)
            valueLab.textColor = HexRGBAlpha(0x666666,1)
            valueLab.font = FontSize(14)
            valueLab.text = "--"
            valueLab.textAlignment = NSTextAlignment.left
            self.contentView.addSubview(valueLab)
            
            switch index {
            case 0:
                lab.textColor = UIColor.black
                valueLab.textColor = UIColor.black
                lab.font = FontSize(16)
                valueLab.font = FontSize(16)
                self.rightOneLab = valueLab
            case 1:
                self.righttwoLab = valueLab
            case 2:
                self.rightthreeLab = valueLab
            case 3:
                self.rightfourLab = valueLab
            case 4:
                self.rightfiveLab = valueLab
            default:
                break;
            }
        }
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        leftImg.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(100)
        }
    }
    
    func updataCellUI(model:TakePicturesModel){
        

        let imgModel:TakePicturesListImgModel?
        imgModel = model.picsList.first
        let url = URL(string: BaseUrl+(imgModel?.imgURL)!)
        leftImg.kf.setImage(with: url)
        
        self.rightOneLab.text = model.title
        self.righttwoLab.text = model.releasePerson
        self.rightthreeLab.text = model.locationName
        self.rightfourLab.text = model.releaseTime
        
        if model.isPublic == "1"{
            self.rightfiveLab.text = "私密"
        }else if model.isPublic == "2"{
            self.rightfiveLab.text = "部分可见"
        }else{
            self.rightfiveLab.text = "公开"
        }
    }
    

}
