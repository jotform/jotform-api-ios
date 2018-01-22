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
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    func createReport(_ formID: Int64, reportParams: [AnyHashable: Any], onSuccess successBlock: @escaping (_ id : AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "https://submit.jotform.com/submit/\(formID)/"
        debugLog(urlStr, params: reportParams)
     
        manager?.responseSerializer = AFHTTPResponseSerializer()
        
        manager?.post(urlStr, parameters: reportParams, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    func createSuggestion(_ formID: Int64, suggestionParams: [AnyHashable: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "https://submit.jotform.me/submit/\(formID)/"
        debugLog(urlStr, params: suggestionParams)
       
        manager?.responseSerializer = AFHTTPResponseSerializer()
        
        manager?.post(urlStr, parameters: suggestionParams, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    func login(_ userinfo: [AnyHashable: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/login"
        debugLog(urlStr, params: userinfo)
       
        manager?.post(urlStr, parameters: userinfo, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    func logout(_ userinfo: [AnyHashable: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/logout?apiKey=\(apiKey)"
        debugLog(urlStr, params: userinfo)
        manager?.post(urlStr, parameters: userinfo, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    func registerUser(_ userinfo: [AnyHashable: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/register?apiKey=\(apiKey)"
        debugLog(urlStr, params: userinfo)
       
          manager?.post(urlStr, parameters: userinfo, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    func getUser(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    func getForms(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/forms?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
       
         manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    func getSubmissions(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/submissions?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
      
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    
    
    func createConditions(_ offset: Int, limit: Int, filter: Dictionary<String, Any>, orderBy: String) -> [AnyHashable: Any] {
        var params = [AnyHashable: Any]()
        
        if offset != 0 {
            params["offset"] = offset
        }
        if limit != 0 {
            params["limit"] = limit
        }
        if  (filter.isEmpty) {
            var filterStr = "%7B"
            var count: Int = 0
            let keys : Array = Array(filter.keys)
            let set = CharacterSet.urlHostAllowed
            
            for key: String in keys {
                if let filterArray: [Any] = filter[key] as? [Any] {
                    filterStr = filterStr + ("%%22\(key)%%22%%3A%%5B")
                
                    for value: String in filterArray as! [String]{
                        filterStr = filterStr + ("%%22\(String(describing: value.addingPercentEncoding(withAllowedCharacters: `set`)))%%22")
                        if filterArray.last as? String != value {
                            filterStr = filterStr + ("%2C")
                        }
                    }
                    filterStr = filterStr + ("%5D")
                } else {
                    let filterString = filter[key] as! String
                    
                    filterStr = filterStr + ("%%22\(key)%%22%%3A%%22\(String(describing: filterString.addingPercentEncoding(withAllowedCharacters: `set`)))%%22")
                    count += 1
                    if count < (filter.count) {
                        filterStr = filterStr + ("%2C")
                    }
                }
            }
            filterStr = filterStr + ("%7D")
            params["filter"] = filterStr
        }
        if (orderBy.count) != 0 {
            params["orderyBy"] = orderBy
        }
        return params
    }


}


