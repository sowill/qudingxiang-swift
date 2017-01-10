//
//  QDXRequireVcodeViewController.swift
//  qudingxiang-swift
//
//  Created by Air on 2017/1/9.
//  Copyright © 2017年 sowill. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON
import HandyJSON

class QDXRequireVcodeViewController: QDXBaseViewController {
    
    public var myTag : Int?
    
    lazy var usernameTF = UITextField()
    lazy var usernameLine = UIView()
    lazy var vcodeTF = UITextField()
    lazy var vcodeLine = UIView()
    lazy var nextStepButton = UIButton()
    lazy var vcodeButton = UIButton()
    lazy var protocolButton = UIButton()
    
    var countdownTimer : Timer?
    
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                
                remainingSeconds = 10
                vcodeButton.setTitleColor(QDXGray, for: .normal)
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                
                vcodeButton.setTitleColor(QDXBlue, for: .normal)
            }
            
            vcodeButton.isEnabled = !newValue
        }
    }
    
    var remainingSeconds: Int = 0 {
        willSet {
            vcodeButton.setTitle("\(newValue)秒后重新获取", for: .normal)
            
            if newValue <= 0 {
                vcodeButton.setTitle("重新获取验证码", for: .normal)
                isCounting = false
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpUI()
    }
    
    func setUpUI(){
        
        self.title = "获取验证码"
        
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

        self.view.addSubview(vcodeTF)
        vcodeTF.borderStyle = UITextBorderStyle.none
        vcodeTF.backgroundColor = UIColor.white
        vcodeTF.placeholder = "请输入验证码:"
        let passwordPaddingView = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(10), height: CGFloat(40)))
        vcodeTF.leftView = passwordPaddingView
        vcodeTF.leftViewMode = .always
        vcodeTF.clearButtonMode = .always
        vcodeTF.isSecureTextEntry = true
        vcodeTF.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(0)
            make.centerX.equalTo(self.view)
            make.height.equalTo(40)
            make.top.equalTo(usernameLine).offset(0.5)
        }
        
        self.view.addSubview(vcodeLine)
        vcodeLine.backgroundColor = QDXLineColor
        vcodeLine.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.top.equalTo(vcodeTF).offset(0.5 + 40)
            make.height.equalTo(0.5)
            make.left.equalTo(0)
        }
        
        self.view.addSubview(nextStepButton)
        nextStepButton.backgroundColor = UIColor.lightGray
        nextStepButton.setTitle("下一步", for: .normal)
        nextStepButton.setTitleColor(UIColor.white, for: .normal)
        nextStepButton.addTarget(self, action: #selector(nextStepClick), for: .touchUpInside)
        nextStepButton.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.left.equalTo(10)
            make.top.equalTo(vcodeTF).offset(70)
            make.height.equalTo(40)
        }
        
        self.view.addSubview(vcodeButton)
        vcodeButton.setTitle("点击获取验证码", for: .normal)
        vcodeButton.setTitleColor(QDXBlue, for: .normal)
        vcodeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        vcodeButton.addTarget(self, action: #selector(vcodeClick), for: .touchUpInside)
        vcodeButton.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(nextStepButton)
            make.centerY.equalTo(vcodeTF)
        }
        
        self.view.addSubview(protocolButton)
        protocolButton.setTitle("注册即表示同意趣定向服务条款", for: .normal)
        protocolButton.setTitleColor(QDXBlue, for: .normal)
        protocolButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        protocolButton.addTarget(self, action: #selector(protocolButtonClick), for: .touchUpInside)
        protocolButton.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view).inset(10)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    func nextStepClick(_ button: UIButton) -> Void {
        
        var parameters: Parameters = [:]
        var urlString = ""
        
        if myTag == 1 {
            parameters = ["code" : usernameTF.text!,"vcode" : vcodeTF.text!]
            urlString = QDXHOSTURL + QDXCreateLoginNURL
        }else{
            parameters = ["tel" : usernameTF.text!,"vcode" : vcodeTF.text!]
            urlString = QDXHOSTURL + QDXGetLoginNURL
        }
        
        Alamofire.request(urlString, method: .post, parameters: parameters).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let swiftyJsonVar = JSON(value)
                
                guard let connect = JSONDeserializer<QDXConnect>.deserializeFrom(json: swiftyJsonVar.description) else {
                    return
                }
                if connect.Code == 0 {
                    _ = SweetAlert().showAlert("failed!", subTitle: connect.Msg, style: AlertStyle.error, buttonTitle:"Cancel")
                    
                }else{
                    
                    print(connect.Msg)
                }
                
            case .failure(let error):
                _ = SweetAlert().showAlert("failed!", subTitle: "please check your network!", style: AlertStyle.error, buttonTitle:"Cancel")
                
                print(error)
            }
        }
        
    }
    
    func vcodeClick(_ button: UIButton) -> Void {
        // 启动倒计时
        isCounting = true
        
        var parameters: Parameters = [:]
        var urlString = ""
        
        if myTag == 1 {
            parameters = ["code" : usernameTF.text!]
            urlString = QDXHOSTURL + QDXGetVcodeNURL
        }else{
            parameters = ["tel" : usernameTF.text!]
            urlString = QDXHOSTURL + QDXCreateVcodeNURL
        }
        
        Alamofire.request(urlString, method: .post, parameters: parameters).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let swiftyJsonVar = JSON(value)
                
                guard let connect = JSONDeserializer<QDXConnect>.deserializeFrom(json: swiftyJsonVar.description) else {
                    return
                }
                if connect.Code == 0 {
                    _ = SweetAlert().showAlert("failed!", subTitle: connect.Msg, style: AlertStyle.error, buttonTitle:"Cancel")
                    
                }else{
                    
                    print(connect.Msg)
                }
                
                
            case .failure(let error):
                _ = SweetAlert().showAlert("failed!", subTitle: "please check your network!", style: AlertStyle.error, buttonTitle:"Cancel")
                
                print(error)
            }
        }
    }
    
    func protocolButtonClick(_ button: UIButton) -> Void{
        
    }
    
    func updateTime(timer: Timer) {
        // 计时开始时，逐秒减少remainingSeconds的值
        remainingSeconds -= 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
