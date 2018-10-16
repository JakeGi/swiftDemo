//
//  newsModel.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/10.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
import SwiftyJSON

class newsModel: NSObject {

    var title:String?
    var titlePicUrl:String?
    var createTime:String?
    var subtitle:String?
    var url:String?
    init(jsonData:JSON){
        title = jsonData["title"].stringValue
        titlePicUrl = jsonData["titlePicUrl"].stringValue
        createTime = jsonData["createTime"].stringValue
        subtitle = jsonData["subtitle"].stringValue
        url = jsonData["url"].stringValue


    }
    
}
