//
//  QDXUserInfo.swift
//  qudingxiang-swift
//
//  Created by Air on 2017/1/5.
//  Copyright © 2017年 sowill. All rights reserved.
//

import UIKit
import HandyJSON

class QDXUserInfo: HandyJSON {
    /**
     token
     */
    var token : String!
    /**
     创建日期
     */
    var cdate : String!
    /**
     IP地址
     */
    var Ipaddress : String!
    /**
     场地ID
     */
    var area_id : Int!
    /**
     手机号
     */
    var code : String!
    /**
     用户ID
     */
    var customer_id : Int!
    /**
     用户名
     */
    var customer_name : String!
    /**
     头像地址
     */
    var headurl : String!
    /**
     上次登录时间
     */
    var ldate : String!
    /**
     用户级别
     */
    var level : String!
    /**
     密码MD5
     */
    var password : String!
    /**
     qid
     */
    var qid : String!
    /**
     个性签名
     */
    var signature : String!
    /**
     验证码
     */
    var vcode : String!
    /**
     wxid
     */
    var wxid : String!
    
    required init(){}
}
