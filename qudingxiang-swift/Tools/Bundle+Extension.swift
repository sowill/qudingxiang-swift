//
//  Bundle+Extension.swift
//  qudingxiang-swift
//
//  Created by Air on 2017/1/22.
//  Copyright © 2017年 sowill. All rights reserved.
//

import Foundation

extension Bundle {

    //计算性属性 类似于函数 没有参数 有返回值
    var nameSpace : String {
        
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }

}
