//
//  ViewController.swift
//  qudingxiang-swift
//
//  Created by Air on 2016/12/28.
//  Copyright © 2016年 sowill. All rights reserved.
//

import UIKit
import SnapKit

class QDXLoginViewController: UIViewController {
    
    lazy var box = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addSubview(box)
        box.backgroundColor = UIColor.black
        box.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(50)
            make.center.equalTo(self.view)
        }
        
        setUpUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func setUpUI(){
        self.view.backgroundColor = UIColor.init(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        self.navigationItem.title = "登录"
        
        
    }
}

