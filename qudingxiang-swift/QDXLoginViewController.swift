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
    
    lazy var usernameTF =  UITextField()
    lazy var usernameLB = UILabel()
    lazy var passwordTF = UITextField()
    lazy var passwordLB = UILabel()
    lazy var loginButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func setUpUI(){
        self.view.backgroundColor = UIColor.init(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        self.navigationItem.title = "登录"
        
        self.view.addSubview(usernameTF)
        usernameTF.borderStyle = UITextBorderStyle.roundedRect
        usernameTF.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(40)
            make.height.equalTo(40)
            make.left.equalTo(20)
        }
        self.view.addSubview(usernameLB)
        usernameLB.text = "用户名必须是5-10位"
        usernameLB.textColor = UIColor.red
        usernameLB.font = UIFont.boldSystemFont(ofSize: 13)
        usernameLB.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(20)
            make.top.equalTo(usernameTF).offset(50)
        }
        
        self.view.addSubview(passwordTF)
        self.view.addSubview(passwordLB)
        self.view.addSubview(loginButton)

    }
}

