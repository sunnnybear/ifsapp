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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 验证用户凭据是否有效，如果有效则跳转到主视图控制器
        if let token = UserDefaults.standard.string(forKey: "AuthToken") {
            // 判断是否过期
            if AuthHelper.isTokenExpaird() {
                print("没有过期，进入主页")
            } else {
                // 显示错误消息
                //showErrorAlert()
                print("Home Error")
                // 从 storyboard 加载登陆视图控制器
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginController = storyboard.instantiateViewController(withIdentifier: "LoginController")
                
                // 将主视图控制器设置为窗口的根视图控制器
                UIApplication.shared.windows.first?.rootViewController = loginController
                
                // 激活窗口
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
        }
        else{
            // 从 storyboard 加载登陆视图控制器
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginController = storyboard.instantiateViewController(withIdentifier: "LoginController")
            
            // 将主视图控制器设置为窗口的根视图控制器
            UIApplication.shared.windows.first?.rootViewController = loginController
            
            // 激活窗口
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://www.baidu.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
