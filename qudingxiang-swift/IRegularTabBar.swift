//
//  IRegularTabBar.swift
//  IRegularTabController
//
//  Created by 卓酉鑫 on 16/7/6.
//  Copyright © 2016年 卓酉鑫. All rights reserved.
//

import UIKit

@objc protocol IRegularBarDelegate: NSObjectProtocol
{
    @objc optional func tabBarClick(_ tabBar: IRegularTabBar)
    
}

class IRegularTabBar: UITabBar {

    var clickDelegate: IRegularBarDelegate?
    var centerButton: UIButton?
    var buttonText: String?
    
    var iRegularMargin: CGFloat {
        get {
            return 10.0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: add CenterButton: designated initializer
    init(frame: CGRect, buttonNormalImage: UIImage, buttonHighlightedImage: UIImage)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        let centerButton: UIButton = UIButton()
        centerButton.setBackgroundImage(buttonNormalImage, for: UIControlState())
        centerButton.setBackgroundImage(buttonHighlightedImage, for: .highlighted)
        
        self.centerButton = centerButton
        
        self.centerButton?.addTarget(self, action: #selector(centerButtonClick(_:)), for: .touchUpInside)
        self.addSubview(self.centerButton!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let centerButton = self.centerButton else { return }
        let tabClass: AnyClass? = NSClassFromString("UITabBarButton")
        
        centerButton.center = CGPoint(x: self.center.x, y: self.frame.height*0.7 - 2 * self.iRegularMargin)
        var newframe = centerButton.frame
        newframe.size = CGSize(width: centerButton.currentBackgroundImage!.size.width, height: centerButton.currentBackgroundImage!.size.height)
        centerButton.frame = newframe

        if let text = self.buttonText
        {
            let label: UILabel = UILabel()
            label.text = text
            label.font = UIFont.systemFont(ofSize: 11)
            label.sizeToFit()
            label.textColor = UIColor.gray
            self.addSubview(label)
            label.center = CGPoint(x: centerButton.center.x, y: centerButton.frame.maxY + self.iRegularMargin)
        }
        
        //个数一般都是偶数
        let tabItemsCount = self.items?.count
        var btnIndex = 0
        
        for subView in self.subviews {
            if subView.isKind(of: tabClass!) {
                var frame = subView.frame
                frame.size.width = self.frame.width / CGFloat((tabItemsCount! + 1))
                frame.origin.x = frame.size.width * CGFloat(btnIndex)
                subView.frame = frame
                btnIndex = btnIndex + 1
                
                if tabItemsCount! / 2 == btnIndex
                {
                    btnIndex = btnIndex + 1
                }
            }
        }
        
        self.bringSubview(toFront: centerButton)
    }
    
    // MARK: Button Action
    func centerButtonClick(_ button: UIButton)
    {
        print("Center button clicked.")
        
        if ((self.clickDelegate?.responds(to: #selector(IRegularBarDelegate.tabBarClick(_:)))) != nil)
        {
            self.clickDelegate?.tabBarClick!(self)
        }
    }
    
    // MARK: override HitTest method
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let centerButton = self.centerButton else { return super.hitTest(point, with: event) }
        if self.isHidden == false
        {
            let newPoint: CGPoint = self.convert(point, to: centerButton)
            
            if centerButton.point(inside: newPoint, with: event)
            {
                return centerButton
            }
        }
        
        return super.hitTest(point, with: event)
    }
}
