//
//  NetworkManager.swift
//  ifsapp
//
//  Created by 韩云鹏 on 2023/4/3.
//

import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func getRequest(urlString: String, parameters: [String: Any]?, completion: @escaping (Result<Data>) -> Void) {
        
        Alamofire.request(urlString, method: .get, parameters: parameters).responseData { response in
            
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func postRequest(urlString: String, parameters: [String: Any]?, completion: @escaping (Result<Data>) -> Void) {
        
        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
            
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

