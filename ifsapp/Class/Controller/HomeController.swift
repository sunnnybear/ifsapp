//
//  HomeController.swift
//  ifsapp
//
//  Created by 韩云鹏 on 2023/3/29.
//

import UIKit
import WebKit

class HomeController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
        
        override func loadView() {
            
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            view = webView
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            
            let myURL = URL(string:"https://www.baidu.com")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        }
}
