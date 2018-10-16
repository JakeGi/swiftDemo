//
//  TakePicturesModel.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/11.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
import SwiftyJSON

struct TakePicturesModel {
    var locationName:String?
    var checkOrgIdStr:String?
    var releaseTime:String?
    var title:String?
    var isPublic:String?
    var id:String?
    var content:String?
    var releasePerson:String?
    var picsList = [TakePicturesListImgModel]()
    init(jsonData:JSON){
        locationName = jsonData["locationName"].stringValue
        checkOrgIdStr = jsonData["checkOrgIdStr"].stringValue
        releaseTime = jsonData["releaseTime"].stringValue
        title = jsonData["title"].stringValue
        isPublic = jsonData["isPublic"].stringValue
        id = jsonData["id"].stringValue
        content = jsonData["content"].stringValue
        releasePerson = jsonData["releasePerson"].stringValue
        picsList = jsonData["picsList"].arrayValue.map{json  in
            TakePicturesListImgModel(jsonDictionary: json)
        }

    }
}
//列表图片
struct TakePicturesListImgModel {
    var imgURL:String?
    var snapId:String?
    var id:String?
    var imgName:String?
    init(jsonDictionary: JSON){
        imgURL = jsonDictionary["imgURL"].stringValue
        snapId = jsonDictionary["snapId"].stringValue
        id = jsonDictionary["id"].stringValue
        imgName = jsonDictionary["imgName"].stringValue
        
    }
}
