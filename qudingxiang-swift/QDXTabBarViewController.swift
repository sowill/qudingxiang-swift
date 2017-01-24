//
//  QDXTabBarViewController.swift
//  qudingxiang-swift
//
//  Created by Air on 2016/12/28.
//  Copyright © 2016年 sowill. All rights reserved.
//

import UIKit

class QDXTabBarController: UITabBarController {
    
    fileprivate lazy var composeBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildControllers()
    }
    
    private func setupChildControllers() {
        
        let array: [[String:Any]] = [
            ["clsName":"QDXHomeViewController","title":"首页","imageName":"home"],
            ["clsName":"QDXActivityViewController","title":"活动","imageName":"location"],
            ["clsName":"QDXOrderViewController","title":"订单","imageName":"order"],
            ["clsName":"QDXMyViewController","title":"我的","imageName":"more"],
        ]
        
        var viewControllerArr = [UIViewController]()
        
        for dic in array {
            viewControllerArr.append(controller(dic: dic))
        }
        
        viewControllers = viewControllerArr
        
    }
    
    /// 使用字典创建子控制器
    ///
    /// - parameter dic: 信息字典[clsName,title,imageName]
    ///
    /// - returns: 子控制器
    private func controller(dic:[String:Any]) ->UIViewController {
        //1 取得字典内容
        guard let clsName = dic["clsName"] as? String,
            let title = dic["title"] as? String,
            let imageName = dic["imageName"] as? String,
            let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? QDXBaseViewController.Type
            else {
                return UIViewController()
        }
        
        //2 创建视图控制器
        let vc = cls.init()
        vc.title = title
        
        //设置控制器的访客信息字典

        
        //3 添加图片
        vc.tabBarItem.image = UIImage(named: "index_" + imageName + "_nomal")
        vc.tabBarItem.selectedImage = UIImage(named: "index_" + imageName + "_click")?.withRenderingMode(.alwaysOriginal)
        //4 修改 tabbar 的标题前景色
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orange], for:.highlighted)
        //修改字体 系统默认是12号
        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 12)], for: .normal)
        
        // 实例化导航控制器 会调用push 方法 讲rootVC 压栈
        let nav = QDXNavigationViewController(rootViewController: vc)
        return nav
    }
}
