//
//  AreaModel.swift
//  qudingxiang-swift
//
//  Created by Air on 2017/1/13.
//  Copyright © 2017年 sowill. All rights reserved.
//

import UIKit
import HandyJSON

class AreaModel: HandyJSON {

    var goods_index : Int!

    var goods_topshow : Int!

    var goods_level : Int!

    var good_st : Int!

    var goods_name : String!

    var good_des : String!

    var act_address : String!

    var good_ct : String!

    var line_id : Int!

    var goods_wxpay : Int!

    var good_url : String!

    var goods_price : String!

    var goods_id : String!

    var act_time : String!

    var good_flag : Int!
    
    var goods_preview : Int!
    
    var goodst : QDXGoodST?
    
    var line : QDXLineModel?
    
    var topshow : QDXTopShow?
    
    required init(){}
}
