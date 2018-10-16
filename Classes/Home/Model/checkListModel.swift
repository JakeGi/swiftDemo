//
//  checkListModel.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/11.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
import SwiftyJSON
struct checkListModel {
    var rectificationImgIds:String?
    var rectificationPersonName:String?
    var id:String?
    var rectificationPersonId:String?
    var recordTime:String?
    var replyType:String?
    var rectifiOrderId:String?
    var checkStatus:String?
    var recordTimeStr:String?
    var rectificationReply:String?
    var units:String?
    var rectificationRequire:String?
    var compleDateStr:String?
    var rectificationPersonStr:String?
    
    init(jsonData:JSON){
        rectificationImgIds = jsonData["rectificationImgIds"].stringValue
        rectificationPersonName = jsonData["rectificationPersonName"].stringValue
        id = jsonData["id"].stringValue
        rectificationPersonId = jsonData["rectificationPersonId"].stringValue
        replyType = jsonData["recordTime"].stringValue
        rectifiOrderId = jsonData["rectifiOrderId"].stringValue
        checkStatus = jsonData["checkStatus"].stringValue
        recordTimeStr = jsonData["recordTimeStr"].stringValue
        rectificationReply = jsonData["rectificationReply"].stringValue
        recordTime = jsonData["recordTime"].stringValue
        units = jsonData["units"].stringValue
        rectificationRequire = jsonData["rectificationRequire"].stringValue
        compleDateStr = jsonData["compleDateStr"].stringValue
        rectificationPersonStr = jsonData["rectificationPersonStr"].stringValue
    }
}
