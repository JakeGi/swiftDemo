//
//  userInfoMode.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/11.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
import SwiftyJSON

struct userInfoMode {

    var teamStr:String?
    var teamId:Int?
    var jobType:Int?
    var name:String?
    var fileList:fileListModel
    var attachmentFileNameList:attachmentFileNameListModel?
    var trainHistoryList = [trainHistoryListModel]()
    var age:Int?
    var type:Int?
    var nativePlace:String?
    var enterTime:String?
    var jobNo:String?
    var id:Int?
    var workTypeStr:String?
    var idCardNo:String?
    var remark:String?
    var workTypeId:String?
    var photoPath:String?
    var sex:Int?
    
    init(jsonData:JSON){
        teamStr = jsonData["teamStr"].stringValue
        teamId = jsonData["teamId"].intValue
        jobType = jsonData["jobType"].intValue
        name = jsonData["name"].stringValue
        fileList = fileListModel(jsonDictionary: jsonData["fileList"])
        attachmentFileNameList = attachmentFileNameListModel(jsonDictionary: jsonData["attachmentFileNameList"])
        trainHistoryList = jsonData["trainHistoryList"].arrayValue.map{json  in
            trainHistoryListModel(jsonDictionary: json)
        }
        age = jsonData["age"].intValue
        type = jsonData["type"].intValue
        nativePlace = jsonData["nativePlace"].stringValue
        enterTime = jsonData["enterTime"].stringValue
        jobNo = jsonData["jobNo"].stringValue
        id = jsonData["id"].intValue
        workTypeStr = jsonData["workTypeStr"].stringValue
        idCardNo = jsonData["idCardNo"].stringValue
        remark = jsonData["remark"].stringValue
        workTypeId = jsonData["workTypeId"].stringValue
        photoPath = jsonData["photoPath"].stringValue
        sex = jsonData["sex"].intValue


    }
    
}
struct fileListModel {
    var filePath:String?
    var id:Int?
    var fileName:String?
    var entryId:Int?
    init(jsonDictionary: JSON){
        filePath = jsonDictionary["filePath"].stringValue
        id = jsonDictionary["id"].intValue
        fileName = jsonDictionary["fileName"].stringValue
        entryId = jsonDictionary["entryId"].intValue
        
    }
}
struct attachmentFileNameListModel {
    
    init(jsonDictionary: JSON){
        
        
    }
}

//签到历史
struct trainHistoryListModel {
    var topic:String?
    var trainDate:String?
    var score:String?
    init(jsonDictionary: JSON){
        trainDate = jsonDictionary["trainDate"].stringValue
        topic = jsonDictionary["topic"].stringValue
        score = jsonDictionary["score"].stringValue
        
    }
}
