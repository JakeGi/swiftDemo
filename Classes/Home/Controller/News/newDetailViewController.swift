//
//  newDetailViewController.swift
//  WisdomOASwift
//
//  Created by 公智能 on 2018/10/10.
//  Copyright © 2018 公智能. All rights reserved.
//

import UIKit
import WebKit
class newDetailViewController: PubBaseViewController {

    // webView
    lazy var webView : WKWebView = {
        let web = WKWebView( frame: CGRect(x:0, y:0,width:kScreenW, height:kScreenH))
        /// 设置代理
        web.navigationDelegate = self
        return web
    }()
    // 进度条
    lazy var progressView:UIProgressView = {
        let progress = UIProgressView()
        progress.progressTintColor = kHighOrangeColor
        progress.trackTintColor = .clear
        return progress
    }()
    var url:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "详细信息"
        self.view.addSubview(self.webView)
        self.view.addSubview(self.progressView)
        
        /// 设置访问的URL
        let url = NSURL(string: self.url!)
        /// 根据URL创建请求
        let requst = NSURLRequest(url: url! as URL)
 
        /// WKWebView加载请求
        self.webView.load(requst as URLRequest)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.progressView.frame = CGRect(x:0,y:0,width:self.view.frame.size.width,height:2)
        self.progressView.isHidden = false
        UIView.animate(withDuration: 1.0) {
            self.progressView.progress = 0.0
        }
    }
    func inittWithTitle(title:String,urlStr:String){
//        self.title = title
        self.url = urlStr
    }

}

extension newDetailViewController:WKNavigationDelegate{
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        self.navigationItem.title = "加载中..."
        /// 获取网页的progress
        UIView.animate(withDuration: 0.5) {
            self.progressView.progress = Float(self.webView.estimatedProgress)
        }
    }
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        /// 获取网页title
        self.title = self.webView.title
        
        UIView.animate(withDuration: 0.5) {
            self.progressView.progress = 1.0
            self.progressView.isHidden = true
        }
    }
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        
        UIView.animate(withDuration: 0.5) {
            self.progressView.progress = 0.0
            self.progressView.isHidden = true
        }
        /// 弹出提示框点击确定返回
        let alertView = UIAlertController.init(title: "提示", message: "加载失败", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title:"确定", style: .default) { okAction in
            _=self.navigationController?.popViewController(animated: true)
        }
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
        
    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        //当前ViewController销毁前将其移除，否则会造成内存泄漏
//        webView.configuration.userContentController.removeScriptMessageHandler(forName: "和web那边一样的方法名")
//    }

}
