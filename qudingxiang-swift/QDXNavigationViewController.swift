//
//  QDXNavigationViewController.swift
//  qudingxiang-swift
//
//  Created by Air on 2016/12/28.
//  Copyright © 2016年 sowill. All rights reserved.
//

import UIKit

class QDXNavigationViewController: UINavigationController ,UINavigationControllerDelegate ,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()

        self.delegate = self

        let navBar = UINavigationBar.appearance(whenContainedInInstancesOf: [QDXNavigationViewController.classForCoder() as! UIAppearanceContainer.Type])
        
        navBar.barTintColor = UIColor.init(displayP3Red:0/255, green: 153/255, blue: 253/255, alpha: 1.0)
        navBar.tintColor = UIColor.white
        navBar.isTranslucent = false
        let dict = [ NSForegroundColorAttributeName : UIColor.white ]
        navBar.titleTextAttributes = dict
        
        // 打印导航栏的交互手势(手势为UIScreenEdgePanGestureRecognizer  屏幕边缘手势)
        // print(self.interactivePopGestureRecognizer?.delegate)
        // Optional(<UIScreenEdgePanGestureRecognizer: 0x7fbc68410700; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7fbc6b00fbe0>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fbc684105c0>)>>)
        
        // 设置全局手势(恢复边缘返回手势的话,需要注释掉下面的代码)
        let pan = UIPanGestureRecognizer(target: self.interactivePopGestureRecognizer?.delegate, action: Selector(("handleNavigationTransition:")))
        pan.delegate = self
        
        self.view.addGestureRecognizer(pan)
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        super.pushViewController(viewController, animated: animated)
        
        // 判断 导航栏子控制器大于2个才具有返回按钮
        if self.childViewControllers.count > 1 {
            
            // 返回按钮
            let returnItem = UIBarButtonItem.init(title: "", style: .plain, target: self, action: #selector(self.pop))
            returnItem.image = UIImage(named:"sign_return")
            
            //用于消除左边空隙，要不然按钮顶不到最前面
            let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                         action: nil)
            spacer.width = -10;
            
            // 设置返回按钮
            viewController.navigationItem.leftBarButtonItems = [spacer, returnItem]
            
            // 取消委托(可以恢复返回上一个界面的手势,只能是边缘返回手势!!!)
            self.interactivePopGestureRecognizer?.delegate = nil
            
        }
        
    }

    // 返回
    func pop() {
        
        self.popViewController(animated: true)
        
    }
    
    // 手势处理
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        // 根据子控制个数来判断什么时候执行返回手势
        print(String(self.childViewControllers.count) + " left drag")
        return self.childViewControllers.count > 1
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
