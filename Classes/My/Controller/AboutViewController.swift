//
//  AboutViewController.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/15.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit

class AboutViewController: PubBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       self.navigationItem.title = "关于应用"
        initSubUI()
    }

    func  initSubUI(){
        
        let contentLab  = UILabel()
        contentLab.text = "智能告警系统是一套针对项目施工中，对关键施工步骤和施工材料进行安全和质量的综合告警管理系统。通过对拌合站生产成品混凝土过程的监控，比对试验室核定数据，实时将超标信息推送至各决策层，及时调整各物料比例，以达到监控施工材料保质保量生产的目的。通过对隧道监控量测数据的提取分析，根据不同围岩级别设定的最大变形量，及时有效的做出预警，为隧道施工保驾护航。本系统利用新型物联网技术，将项目施工过程中产生的过程数据进行采集、处理及分析，并将超标数据进行实时预警，为项目施工方及监管部门提供安全质量信息的即时感知，帮助工程项目把控施工质量、识别安全风险，实现工程项目建设统一化、动态化及高效化管理。"
        contentLab.textAlignment = NSTextAlignment.left
        contentLab.numberOfLines = 0
        contentLab.font = FontSize(17)
        self.view.addSubview(contentLab)
        
        contentLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(20)
        }
    }

}
