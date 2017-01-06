//
//  ViewController.swift
//  qudingxiang-swift
//
//  Created by Air on 2016/12/28.
//  Copyright © 2016年 sowill. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON
import MJExtension

class QDXLoginViewController: UIViewController {
    
    lazy var usernameTF =  UITextField()
    lazy var usernameLine = UIView()
    lazy var passwordTF = UITextField()
    lazy var passwordLine = UIView()
    lazy var loginButton = UIButton()
    lazy var forgetButton = UIButton()
    lazy var registerButton = UIButton()
    
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
        self.view.backgroundColor = QDXBGColor
        self.navigationItem.title = "登录"
        
        self.view.addSubview(usernameTF)
        usernameTF.borderStyle = UITextBorderStyle.none
        usernameTF.backgroundColor = UIColor.white
        usernameTF.placeholder = "请输入手机号:"
        let usernamePaddingView = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(10), height: CGFloat(40)))
        usernameTF.leftView = usernamePaddingView
        usernameTF.leftViewMode = .always
        usernameTF.keyboardType = .numberPad
        usernameTF.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.top.equalTo(10)
            make.height.equalTo(40)
            make.left.equalTo(0)
        }
        
        self.view.addSubview(usernameLine)
        usernameLine.backgroundColor = QDXLineColor
        usernameLine.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.top.equalTo(10 + 40)
            make.height.equalTo(0.5)
            make.left.equalTo(0)
        }
        
        self.view.addSubview(passwordTF)
        passwordTF.borderStyle = UITextBorderStyle.none
        passwordTF.backgroundColor = UIColor.white
        passwordTF.placeholder = "请输入密码"
        let passwordPaddingView = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(10), height: CGFloat(40)))
        passwordTF.leftView = passwordPaddingView
        passwordTF.leftViewMode = .always
        passwordTF.clearButtonMode = .always
        passwordTF.isSecureTextEntry = true
        passwordTF.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(0)
            make.centerX.equalTo(self.view)
            make.height.equalTo(40)
            make.top.equalTo(usernameLine).offset(0.5)
        }
        
        self.view.addSubview(passwordLine)
        passwordLine.backgroundColor = QDXLineColor
        passwordLine.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.top.equalTo(passwordTF).offset(0.5 + 40)
            make.height.equalTo(0.5)
            make.left.equalTo(0)
        }
        
        self.view.addSubview(loginButton)
        loginButton.backgroundColor = UIColor.lightGray
        loginButton.setTitle("登录", for: UIControlState.normal)
        loginButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        loginButton.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        loginButton.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.left.equalTo(10)
            make.top.equalTo(passwordTF).offset(70)
            make.height.equalTo(40)
        }
        
        self.view.addSubview(forgetButton)
        forgetButton.setTitle("忘记密码", for: UIControlState.normal)
        forgetButton.setTitleColor(QDXGray, for: UIControlState.normal)
        forgetButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        forgetButton.addTarget(self, action: #selector(forgetClick), for: .touchUpInside)
        forgetButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(loginButton)
            make.top.equalTo(loginButton).offset(40)
        }
        
        self.view.addSubview(registerButton)
        registerButton.setTitle("立即注册", for: UIControlState.normal)
        registerButton.setTitleColor(QDXBlue, for: UIControlState.normal)
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        registerButton.addTarget(self, action: #selector(registerClick), for: .touchUpInside)
        registerButton.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(loginButton)
            make.top.equalTo(loginButton).offset(40)
        }

    }
    
    func loginClick(_ button: UIButton) -> Void {
        let code = usernameTF.text!
        let password = passwordTF.text!
        
        let parameters: Parameters = ["code" : code,"password" : password]
        let urlString = "https://www.qudingxiang.cn/index.php/Home/Customer/login"
        
        Alamofire.request(urlString, method: .post, parameters: parameters).responseJSON { (response) in
            let json = JSON(response.result.value!)
            
            print(json["Msg"])
            
            let userInfo = QDXUserInfo.mj_object(withKeyValues: json["Msg"])
            
            print(userInfo?.token)
        }
    }
    
    func forgetClick(_ button: UIButton) -> Void {
        
    }
    
    func registerClick(_ button: UIButton) -> Void {
        
    }
}

