//
//  NetworkService.swift
//  K3
//
//  Created by Timur Koshevoy on 23.01.2020.
//  Copyright © 2020 Timur Koshevoy. All rights reserved.
//

import Foundation
import Alamofire
import SystemConfiguration

class NetworkService {
    
    private func makeURL(tag: String) -> URL{    
        let baseURL = "http://api.tumblr.com/v2/"
        let apiKey = "CcEqqSrYdQ5qTHFWssSMof4tPZ89sfx6AXYNQ4eoXHMgPJE03U"
        return URL(string: "\(baseURL)tagged?tag=\(tag)&api_key=\(apiKey)")!
    }
    
    func getPostsFromNetwork(tag: String, completion: @escaping (_ response: Data?, _ error: String?) -> Void) {
        
        if connection() {
            AF.request(makeURL(tag: tag), method: .get ).responseJSON { (responseData) in
                guard responseData.response != nil else {
                    print("Fail to load from network")
                    completion(nil, "Fail to load from network")
                    return
                }
                let data = responseData.data
                
                completion(data, nil)
            }
        } else {
            completion(nil, "Fail to load from network")
        }
          
    }
    
    func connection() -> Bool{
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero:(0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress){
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1){zeroSockAdress in SCNetworkReachabilityCreateWithAddress(nil, zeroSockAdress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false{
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
    }
}
