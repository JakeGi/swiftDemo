//
//  NoticeModel.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/10.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
import SwiftyJSON
struct NoticeModel {

    var orgId:Int?
    var title:String?
    var createTime:String?
    var issuedNo:String?
    var createUserName:String?
    var content:String?
    init(jsonData:JSON) {
        orgId = jsonData["orgId"].intValue
        title = jsonData["title"].stringValue
        createTime = jsonData["createTime"].stringValue
        issuedNo = jsonData["issuedNo"].stringValue
        createUserName = jsonData["createUserName"].stringValue
        content = jsonData["content"].stringValue

    }
    
}
