//
//  OrgMarkModel.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/16.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
import SwiftyJSON
struct OrgMarkModel {
    
    var name:String?
    var createtime:String?
    var orgno:String?
    var parentid:String?
    var orgid:String?
    var units:String?
    var orgtypeid:String?
    var tenderno:String?
    init(jsonData:JSON){
        name = jsonData["name"].stringValue
        createtime = jsonData["createtime"].stringValue
        orgno = jsonData["orgno"].stringValue
        parentid = jsonData["parentid"].stringValue
        orgid = jsonData["orgid"].stringValue
        units = jsonData["units"].stringValue
        orgtypeid = jsonData["orgtypeid"].stringValue
        tenderno = jsonData["tenderno"].stringValue
    }
    

}
