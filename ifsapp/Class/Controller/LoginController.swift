//
//  LoginController.swift
//  ifsapp
//
//  Created by 韩云鹏 on 2023/3/29.
//
import UIKit

class LoginController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - IBActions
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        login()
    }
    
    
    // MARK: - Private Methods
    
    private func login() {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            return
        }
        
        let parameters = [
            "username": username,
            "password": password
        ]
        
        NetworkManager.shared.postRequest(urlString:Server.MOCK_SERVER+Server.LOGIN_URL , parameters: parameters) { result in
            switch result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let success = json?["success"] as? Bool,
                       let message = json?["message"] as? String,
                       let data = json?["data"] as? [String: Any],
                       let token = data["token"] as? String ,
                       let expair = data["expair"] as? Double {
                        // Use the token as needed
                        print("Token: \(token)")
                        print("expair: \(expair)")
                        
                        // 保存token和过期时间戳
                        UserDefaults.standard.set(token, forKey: "AuthToken")
                        UserDefaults.standard.set(expair, forKey: "AuthExpair")
                        
                        // 登陆成功后跳转到HomeController
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let homeController = storyboard.instantiateViewController(withIdentifier: "HomeController")
                        
                        // 将主视图控制器设置为窗口的根视图控制器
                        UIApplication.shared.windows.first?.rootViewController = homeController
                        
                        // 激活窗口
                        UIApplication.shared.windows.first?.makeKeyAndVisible()
                    } else {
                        // Handle the case where some key is missing or has the wrong type
                        print("Invalid JSON format")
                    }
                } catch {
                    print("Error parsing JSON: \(error.localizedDescription)")
                }
            case .failure(let error):
                // Handle the error response
                print("Request failed with error: \(error.localizedDescription)")
            }
        }
    }
}
