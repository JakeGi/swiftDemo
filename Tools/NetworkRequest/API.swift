//
//  API.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/8.
//  Copyright © 2018 公智能. All rights reserved.
//

import Foundation

let BaseUrl = "http://117.34.91.251:8015/imp"    //西镇
//let BaseUrl = "http://117.34.91.90:8917/imp/"  //太风



//图片url
let uAPILoadImage               = "/imageManage/show.do?fileName="

//登录
let loginUrl                    = "/android/loginForTF.do"
//公告列表
let uAPI_Notice_PublicList      = "/announcement/getAnnouncementList.do"
//新闻
let uAPI_News_NewsPage          = "/news/showTitleByPage.do"
//扫码后获取个人信息
let uAPI_User_UserInfo          = "/entryRegister/selectById.do"
//质量 检查列表
let uAPI_Quality_CheckList      = "/qualityCheck/showQualityCheckList.do"
//质量 整改列表
let uAPI_Quality_UpdateList     = "/qualityRectifiOrder/showRectifiOrderList.do"
//安全 整改列表
let uAPI_Safe_UpdateList        = "/rectifiOrder/showRectifiOrderList.do"
//随手拍 - 列表
let uAPI_TakePic_showList       = "/snapshot/showAll.do"
//主页 消息个数
let uAPI_PCMO_Home_GetSendNum   = "/warningRead/getSendNum.do"
//主页 拌合站报警列表
let uAPI_Refer_MS_Station_List  = "/warningRead/getSendMsg.do"
//获取下载二维码
let uAPI_User_Help_Donwload     = "/appUpdate/byQrcodeLoadApp.do"
// 获取注意事项
let uAPI_User_Help_Items        = "/operationManual/appShowNoticeMatters.do"
//查询组织结构列表
let uAPI_OrganizationList       = "/org/selectOrgByOrgIdForAndroid.do"
//查询 拌合站查询 - 拌合机列表
let uAPI_SiteMachineList        = "/mixMachineQuery/selectMixMachineModelsApp.do"
//查询 施工部位
let uAPI_Search_WorkPart        = "/mixMachineQuery/selectTeamInforModelsApp.do"
