//
//  QualityViewController.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/9/29.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit

class QualityViewController: PubBaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "质量检查"
        
        creatUI()
        
    }

    private func creatUI(){
        let bgImg = UIImageView()
        bgImg.image = UIImage(named: "img_pro_bg")
        self.view.addSubview(bgImg)
        
        bgImg.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        let firstBtn = UIButton()
        firstBtn.layer.cornerRadius = 5
        firstBtn.hw_locationAdjust(buttonMode: .Left, spacing: 30)
        firstBtn.setImage(UIImage(named: "wd_check_left_look"), for: .normal)
        firstBtn.addTarget(self, action:#selector(firstBtnClcik) , for: .touchUpInside)
        firstBtn.setTitle("质量检查", for: .normal)
        firstBtn.backgroundColor = HexRGBAlpha(0x0c84d2,1)
        self.view.addSubview(firstBtn)
        firstBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(20)
            make.width.equalTo(kScreenW-60)
            make.centerX.equalTo(self.view)
            make.height.equalTo(100)
        }
        
        let secondBtn = UIButton()
        secondBtn.layer.cornerRadius = 5
        secondBtn.hw_locationAdjust(buttonMode: .Left, spacing: 30)
        secondBtn.setImage(UIImage(named: "wd_check_left_change"), for: .normal)
        secondBtn.setTitle("质量整改", for: .normal)
        secondBtn.addTarget(self, action:#selector(secondBtnClcik) , for: .touchUpInside)
        secondBtn.backgroundColor = HexRGBAlpha(0x5bb923,1)
        self.view.addSubview(secondBtn)
        secondBtn.snp.makeConstraints { (make) in
            make.top.equalTo(firstBtn.snp.bottom).offset(20)
            make.width.equalTo(kScreenW-60)
            make.centerX.equalTo(self.view)
            make.height.equalTo(100)
        }
        
    
        let addBtn = UIButton()
        addBtn.setImage(UIImage(named: "wd_check_addbtn"), for: .normal)
        addBtn.addTarget(self, action:#selector(addBtnClcik) , for: .touchUpInside)
        self.view.addSubview(addBtn)
        addBtn.snp.makeConstraints { (make) in
            make.top.equalTo(secondBtn.snp.bottom).offset(40)
            make.centerX.equalTo(self.view)
        }

    }
    //质量检查
    @objc func firstBtnClcik(){
        let vc = checkListViewController()
        vc.navTitle = "质量检查"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    //质量整改
    @objc func secondBtnClcik(){
        let vc = checkListViewController()
        vc.navTitle = "质量整改"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //添加r
    @objc func addBtnClcik(){
        
    }

}
