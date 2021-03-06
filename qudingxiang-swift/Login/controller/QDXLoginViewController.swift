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
import HandyJSON

class QDXLoginViewController: QDXBaseViewController {
    
    lazy var usernameTF = UITextField()
    lazy var usernameLine = UIView()
    lazy var passwordTF = UITextField()
    lazy var passwordLine = UIView()
    lazy var loginButton = UIButton()
    lazy var forgetButton = UIButton()
    lazy var registerButton = UIButton()
    
    var QDXUserModel = QDXUserInfo()
    
    var window: UIWindow?
    
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
        passwordTF.placeholder = "请输入密码:"
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
        loginButton.backgroundColor = QDXBlue
        loginButton.setTitle("登录", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        loginButton.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.left.equalTo(10)
            make.top.equalTo(passwordTF).offset(70)
            make.height.equalTo(40)
        }
        
        self.view.addSubview(forgetButton)
        forgetButton.setTitle("忘记密码", for: .normal)
        forgetButton.setTitleColor(QDXGray, for: .normal)
        forgetButton.tag = 1
        forgetButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        forgetButton.addTarget(self, action: #selector(requireVcodeClick), for: .touchUpInside)
        forgetButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(loginButton)
            make.top.equalTo(loginButton).offset(40)
        }
        
        self.view.addSubview(registerButton)
        registerButton.setTitle("立即注册", for: .normal)
        registerButton.setTitleColor(QDXBlue, for: .normal)
        registerButton.tag = 2
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        registerButton.addTarget(self, action: #selector(requireVcodeClick), for: .touchUpInside)
        registerButton.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(loginButton)
            make.top.equalTo(loginButton).offset(40)
        }
        
        //第三方登录

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    func loginClick(_ button: UIButton) -> Void {
        
        self.view.endEditing(false)
        loginButton.isUserInteractionEnabled = false
        loginButton.backgroundColor = QDXLightGray
        
        let parameters: Parameters = ["code" : usernameTF.text!,"password" : passwordTF.text!]
        let urlString = QDXHOSTURL + QDXLOGINURL
        
        Alamofire.request(urlString, method: .post, parameters: parameters).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let swiftyJsonVar = JSON(value)
                
                guard let connect = JSONDeserializer<QDXConnect>.deserializeFrom(json: swiftyJsonVar.description) else {
                    return
                }
                if connect.Code == 0 {
                    _ = SweetAlert().showAlert("failed login!", subTitle: connect.Msg, style: AlertStyle.error, buttonTitle:"Cancel")
    
                }else{

                    guard let userInfo = JSONDeserializer<QDXUserInfo>.deserializeFrom(json: swiftyJsonVar["Msg"].description) else {
                        return
                    }
                    
//                    print(userInfo.customer_name + " " + userInfo.vcode)
                    
                    self.QDXUserModel = userInfo
                    
                    let first = QDXNavigationViewController.init(rootViewController: QDXHomeViewController.init())
                    let second = QDXNavigationViewController.init(rootViewController: QDXActivityViewController.init())
                    let third = QDXNavigationViewController.init(rootViewController: QDXOrderViewController.init())
                    let fourth = QDXNavigationViewController.init(rootViewController: QDXMyViewController.init())
                    
                    let vcs = [first, second, third, fourth]
                    
                    let tabBarController = IRegularController(childVCs: vcs)
                    
                    self.window = UIWindow()
                    self.window?.rootViewController = tabBarController
                    self.window?.makeKeyAndVisible()
                    
//                    let homeVC = QDXHomeViewController()
//                    
//                    homeVC.qdxUserModel = self.QDXUserModel
//     
//                    self.navigationController?.pushViewController(homeVC, animated: true)
                    
                }
                
                self.loginButton.isUserInteractionEnabled = true
                self.loginButton.backgroundColor = QDXBlue
            case .failure(let error):
                _ = SweetAlert().showAlert("network error!", subTitle: "please check your network!", style: AlertStyle.error, buttonTitle:"Cancel")
                self.loginButton.isUserInteractionEnabled = true
                self.loginButton.backgroundColor = QDXBlue
                print(error)
            }
        }
    }
    
    func requireVcodeClick(_ button: UIButton) -> Void {
        
        let tag = button.tag
        
        let requireVcodeVC = QDXRequireVcodeViewController()
        
        requireVcodeVC.myTag = tag
        
        self.navigationController?.pushViewController(requireVcodeVC, animated: true)
    }
}

