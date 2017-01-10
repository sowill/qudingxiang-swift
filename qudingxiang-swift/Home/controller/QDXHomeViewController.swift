//
//  QDXHomeViewController.swift
//  qudingxiang-swift
//
//  Created by Air on 2017/1/9.
//  Copyright © 2017年 sowill. All rights reserved.
//

import UIKit

class QDXHomeViewController: QDXBaseViewController{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpUI()
    }
    
    func setUpUI(){
        self.navigationItem.title = "主页"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
