//
//  JotForm.swift
//  JotForm_iOS
//
//  Created by Curtis Stilwell on 1/21/18.
//  Copyright © 2018 Interlogy, LLC. All rights reserved.
//

import Foundation

class JotForm {
    private var manager: AFHTTPSessionManager?
    private var apiKey = ""
    private var baseUrl = ""
    private var debugMode = false
    
    func debugLog(_ urlStr: String, params: Any?) {
        if debugMode {
            var paramsStr = ""
            if (params is String) {
                paramsStr = params as? String ?? ""
            }
            else if (params is [AnyHashable: Any]) {
                paramsStr = (params as AnyObject).description
            }
            
            print("urlstr = \(urlStr)")
            if (paramsStr.count) > 0 {
                print("paramstr = \(paramsStr)")
            }
        }
    }

    func executeGetEUapi(path: String, onSuccess successBlock:@escaping (_ id : AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/\(path)"
        debugLog(urlStr, params: nil)
        
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error?) -> Void in
            failureBlock(error!)
        })
    }
}


