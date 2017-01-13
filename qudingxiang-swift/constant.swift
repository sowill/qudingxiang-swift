//
//  constant.swift
//  qudingxiang-swift
//
//  Created by Air on 2017/1/4.
//  Copyright © 2017年 sowill. All rights reserved.
//

import UIKit

/** 
 颜色转换
 */
func UIColorFromRGB(rgbValue:Int) -> UIColor
{
    return UIColor(red: CGFloat((Float((rgbValue & 0xff0000) >> 16)) / 255.0), green: CGFloat((Float((rgbValue & 0xff00) >> 8)) / 255.0), blue: CGFloat((Float(rgbValue & 0xff)) / 255.0), alpha: CGFloat(1.0))
}

let QDXBGColor = UIColorFromRGB(rgbValue: 0xf5f5f5)

let QDXGray = UIColorFromRGB(rgbValue: 0x666666)

let QDXBlue = UIColorFromRGB(rgbValue: 0x0099fd)

let QDXBlack = UIColorFromRGB(rgbValue: 0x111111)

let QDXOrange = UIColorFromRGB(rgbValue: 0xff5100)

let QDXLineColor = UIColorFromRGB(rgbValue: 0xe5e5e5)

let QDXDarkBlue = UIColorFromRGB(rgbValue: 0x0089e3)

let QDXLightGray = UIColorFromRGB(rgbValue: 0xd6d6d6)

/**
 屏幕宽高
 */
let QDXScreenWidth = UIScreen.main.bounds.width

let QDXSereenHeight = UIScreen.main.bounds.height

/**
 服务器地址
 */
let QDXHOSTURL = "https://www.qudingxiang.cn/index.php/"
/**
 服务器地址
 */
let QDXHOSTWithURL = "https://www.qudingxiang.cn/"
/**
 登录地址
 */
let QDXLOGINURL = "Home/Customer/login"
/**
 忘记密码登录地址
 */
let QDXGetLoginNURL = "Home/Customer/vcodeLogin"
/**
 注册验证地址
 */
let QDXCreateLoginNURL = "Home/Customer/validateCode"
/**
 忘记密码获取验证码地址
 */
let QDXGetVcodeNURL = "Home/Customer/getVcode"
/**
 注册获取验证码地址
 */
let QDXCreateVcodeNURL = "Home/Customer/setVcode"
/**
 获取场地列表地址
 */
let QDXAreaListURL = "Home/goods/getListAjaxAct"

