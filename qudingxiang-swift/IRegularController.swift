//
//  IRegularController.swift
//  IRegularTabController
//
//  Created by 卓酉鑫 on 16/7/6.
//  Copyright © 2016年 卓酉鑫. All rights reserved.
//

import UIKit

class IRegularController: UITabBarController {
    
    var childVCs: [UIViewController]?
    
    override class func initialize()
    {
        let tabBarItem = UITabBarItem.appearance(whenContainedInInstancesOf: [self])
        
        var dictNormal: [String : AnyObject] = [:]
        dictNormal[NSForegroundColorAttributeName] = UIColor.gray
        dictNormal[NSFontAttributeName] = UIFont.systemFont(ofSize: 11)
        
        var dictSelected: [String : AnyObject] = [:]
        dictSelected[NSForegroundColorAttributeName] = UIColor.darkGray
        dictSelected[NSFontAttributeName] = UIFont.systemFont(ofSize: 11)
        
        tabBarItem.setTitleTextAttributes(dictNormal, for: UIControlState())
        tabBarItem.setTitleTextAttributes(dictSelected, for: .selected)
    }
    
    init(childVCs: [UIViewController])
    {
        super.init(nibName: nil, bundle: nil)
        self.childVCs = childVCs
        self.setUpAllChildVC()
        
        let post_normalImage: UIImage? = UIImage(named: "go-常态")
        
        let tabBar = IRegularTabBar(frame: self.view.frame, buttonNormalImage: post_normalImage!, buttonHighlightedImage: post_normalImage!)
        tabBar.clickDelegate = self
        
        self.setValue(tabBar, forKey: "tabBar")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: 创建childVC
    func setUpAllChildVC()
    {
        guard let childVCs = self.childVCs else { return }

        for vc in childVCs
        {
            self.addChildViewController(vc)
        }
    }
    
}

extension IRegularController: IRegularBarDelegate
{
    func tabBarClick(_ tabBar: IRegularTabBar) {
        print("delecate implements click Button.")
    }
}
