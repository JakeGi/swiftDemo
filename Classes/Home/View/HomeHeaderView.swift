//
//  HomeHeaderView.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/9/28.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
import SBCycleScrollView
class HomeHeaderView: UITableViewHeaderFooterView,CycleScrollViewDelegate{
    //声明闭包
    typealias bannerClick = (NSInteger) ->Void
    //声明属性
    var bannerClickBlock:bannerClick?
    lazy var cycleScrollView : CycleScrollView =  {
        CycleScrollView.initScrollView(frame: self.bounds, delegate: self, placehoder: UIImage.init(named: "home_box_01"), cycleOptions: CycleOptions())

        
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        cycleScrollView.frame = self.bounds
//        cycleScrollView.delegate = self

    }
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(cycleScrollView)
        contentView.backgroundColor = kWhite
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //banner点击事件
    
    func didSelectedCycleScrollView(_ cycleScrollView: CycleScrollView, _ Index: NSInteger) {
        if bannerClickBlock != nil
        {
            bannerClickBlock!(Index)
        }
        
    }
}
