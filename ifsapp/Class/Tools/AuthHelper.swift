//
//  AuthHelper.swift
//  ifsapp
//
//  Created by 韩云鹏 on 2023/4/3.
//

import Foundation

class AuthHelper {
    
    static func isTokenValid(_ token: String) -> Bool {
        // 解析令牌
        guard let data = token.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let expiresAt = json["expiresAt"] as? TimeInterval
        else {
            // 无效的令牌格式
            return false
        }
        
        // 检查到期时间戳是否大于当前时间戳
        let currentTime = Date().timeIntervalSince1970
        return expiresAt > currentTime
    }
    
}
