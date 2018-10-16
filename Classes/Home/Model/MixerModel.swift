//
//  MixerModel.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/16.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
import SwiftyJSON

struct MixerModel {
    var address:String?
    var name:String?
    var id:String?
    var sectionId:String?
    init(jsonData:JSON){
        address = jsonData["address"].stringValue
        name = jsonData["name"].stringValue
        id = jsonData["id"].stringValue
        sectionId = jsonData["sectionId"].stringValue

    }
}
