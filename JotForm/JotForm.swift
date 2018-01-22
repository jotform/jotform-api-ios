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
    
    func getSubusers(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/subusers?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
      
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    func getFolders(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/users/folders?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
       
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    func getFolder(_ folderID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/folder/\(folderID)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }

    func getReports(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/reports/apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
      
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    func deleteReport(_ reportID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/reports/\(reportID)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
       
        manager?.delete(urlStr, parameters: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    func getSettings(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/settings?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    func updateSettings(_ settings: [AnyHashable: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/settings?apiKey=\(apiKey)"
        debugLog(urlStr, params: settings)
        
        manager?.post(urlStr, parameters: settings, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    func getHistory(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/history?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
       
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    func getHistory(_ action: String, date: String, sortBy: String, startDate: String, endDate: String, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/history?apiKey=\(apiKey)"
        let params = createHistoryQuery(action, date: date, sortBy: sortBy, startDate: startDate, endDate: endDate)
        debugLog(urlStr, params: params)
        
        manager?.get(urlStr, parameters: params, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    func getForm(_ formID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    func getFormQuestions(_ formID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/questions?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
       
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    func getFormQuestion(_ formID: Int64, questionID qid: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/question/\(qid)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    func getFormSubmissions(_ formID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/submissions?apiKey=\(apiKey)"
        var params = [AnyHashable: Any]()
        params["qid_enabled"] = "true"
        debugLog(urlStr, params: params)
        
        manager?.get(urlStr, parameters: params, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }

    func getFormSubmissions(_ formID: Int64, offset: Int, limit: Int, orderBy: String, filter: [AnyHashable: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/submissions?apiKey=\(apiKey)"
        let params = createConditions(offset, limit: limit, filter: filter, orderBy: orderBy)
        debugLog(urlStr, params: params)
      
        manager?.get(urlStr, parameters: params, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    
    
    func getReport(_ reportID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/report/\(reportID)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
      
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    func createHistoryQuery(_ action: String, date: String, sortBy: String, startDate: String, endDate: String) -> [AnyHashable: Any] {
        var params = [AnyHashable: Any]()
       
        if action.count != 0 {
           params["action"] = action
        }
       
        if date.count != 0 {
           params["date"] = date
        }
       
        if sortBy.count != 0 {
           params["sortBy"] = sortBy
        }
        
        if startDate.count != 0 {
           params["startDate"] = startDate
        }
        
        if endDate.count != 0 {
           params["endDate"] = endDate
        }
        
        return params
    }
    
    func createConditions(_ offset: Int, limit: Int, filter: [AnyHashable: Any], orderBy: String) -> [AnyHashable: Any] {
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
            
            for key: String in keys as! [String] {
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


