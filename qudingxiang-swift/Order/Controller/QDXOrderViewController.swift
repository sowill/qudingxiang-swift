//
//  QDXOrderViewController.swift
//  qudingxiang-swift
//
//  Created by Air on 2017/1/22.
//  Copyright © 2017年 sowill. All rights reserved.
//

import UIKit

class QDXOrderViewController: QDXBaseViewController {

    init()
    {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.title = "订单"
        self.tabBarItem.image = UIImage(named: "index_order_nomal")?.withRenderingMode(.alwaysOriginal)
        self.tabBarItem.selectedImage = UIImage(named: "index_order_click")?.withRenderingMode(.alwaysOriginal)
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

}
