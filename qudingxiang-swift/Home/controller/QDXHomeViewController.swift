//
//  QDXHomeViewController.swift
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
import Kingfisher

class QDXHomeViewController: QDXBaseViewController{

    let imageCount = 4
    var scrollView: UIScrollView!
    var pageView: UIPageControl!
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topDataRequire()
        setUpUI()
        addTimer()
    }
    
    func topDataRequire() {
        
        let parameters: Parameters = ["areatype_id":"2","curr":"1"]
        let urlString = QDXHOSTURL + QDXAreaListURL
        
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
                    guard let areaModels = JSONDeserializer<AreaModel>.deserializeModelArrayFrom(json: swiftyJsonVar["Msg"]["data"].description) else {
                        return
                    }
                    
                    areaModels.forEach({ (areaModel) in
                        print(areaModel!.good_url)
                    })
                    
                }

            case .failure(let error):
                _ = SweetAlert().showAlert("network error!", subTitle: "please check your network!", style: AlertStyle.error, buttonTitle:"Cancel")
                
                print(error)
            }
        }
    }
    
    func setUpUI(){
        self.navigationItem.title = "主页"
        
        automaticallyAdjustsScrollViewInsets = false
        
        do {
            scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: QDXScreenWidth, height: 200))
            scrollView.delegate = self
            view.addSubview(scrollView)
        }
        
        do {
            pageView = UIPageControl(frame: CGRect(x: 0, y: 200 - 30, width: QDXScreenWidth, height: 30))
            view.addSubview(pageView)
            pageView.numberOfPages = imageCount
            pageView.currentPage = 0
            pageView.pageIndicatorTintColor = UIColor.white
            pageView.currentPageIndicatorTintColor = UIColor.blue
        }
        
        do {
            /// 只使用3个UIImageView，依次设置好最后一个，第一个，第二个图片，这里面使用取模运算。
            for index in 0..<3 {
                let imageView = UIImageView(frame: CGRect(x: CGFloat(index) * QDXScreenWidth, y: 0, width: QDXScreenWidth, height: 200))
                imageView.image = UIImage(named: "\((index + 3) % 4).png")
                scrollView.addSubview(imageView)
            }
        }
        
        do {
            scrollView.contentSize = CGSize(width: QDXScreenWidth * 3, height: 0)
            scrollView.contentOffset = CGPoint(x: QDXScreenWidth, y: 0)
            scrollView.isPagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
        }
    }
    
    /// 添加timer
    func addTimer() {
        /// 利用这种方式添加的timer 如果有列表滑动的话不会调用这个timer，因为当前runloop的mode更换了
        //        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { [weak self] (timer) in
        //            self?.nextImage()
        //        })
        
        timer = Timer(timeInterval: 2, repeats: true, block: { [weak self] _ in
            self?.nextImage()
        })
        
        guard let timer = timer else {
            return
        }
        RunLoop.current.add(timer, forMode: .commonModes)
    }
    
    func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    /// 下一个图片
    func nextImage() {
        if pageView.currentPage == imageCount - 1 {
            pageView.currentPage = 0
        } else {
            pageView.currentPage += 1
        }
        let contentOffset = CGPoint(x: QDXScreenWidth * 2, y: 0)
        scrollView.setContentOffset(contentOffset, animated: true)
    }
    
    /// 上一个图片
    func preImage() {
        if pageView.currentPage == 0 {
            pageView.currentPage = imageCount - 1
        } else {
            pageView.currentPage -= 1
        }
        
        let contentOffset = CGPoint(x: 0, y: 0)
        scrollView.setContentOffset(contentOffset, animated: true)
    }
    
    /// 重新加载图片，重新设置3个imageView
    func reloadImage() {
        let currentIndex = pageView.currentPage
        let nextIndex = (currentIndex + 1) % 4
        let preIndex = (currentIndex + 3) % 4
        
        (scrollView.subviews[0] as! UIImageView).image = UIImage(named: "\(preIndex).png")
        (scrollView.subviews[1] as! UIImageView).image = UIImage(named: "\(currentIndex).png")
        (scrollView.subviews[2] as! UIImageView).image = UIImage(named: "\(nextIndex).png")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension QDXHomeViewController:UIScrollViewDelegate{
    /// 开始滑动的时候，停止timer，设置为niltimer才会销毁
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    /// 当停止滚动的时候重新设置三个ImageView的内容，然后悄悄滴显示中间那个imageView
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        reloadImage()
        scrollView.setContentOffset(CGPoint(x: QDXScreenWidth, y: 0), animated: false)
    }
    
    /// 停止拖拽，开始timer, 并且判断是显示上一个图片还是下一个图片
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
        
        if scrollView.contentOffset.x < QDXScreenWidth {
            preImage()
        } else {
            nextImage()
        }
    }
}
