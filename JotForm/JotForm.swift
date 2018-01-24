//
//  JotForm.swift
//  JotForm_iOS
//
//  Created by Curtis Stilwell on 1/21/18.
//  Copyright © 2018 Interlogy, LLC. All rights reserved.
//

import Foundation
import AFNetworking

public class JotForm {
    private var manager: AFHTTPSessionManager?
    private var apiKey = ""
    private var baseUrl = ""
    private var debugMode = false
    
    let BASE_URL = "https://api.jotform.com"
    let BASE_URL_EU = "https://eu-api.jotform.com"
    
   public init(apiKey apikey: String, debugMode debugmode: Bool, euApi: Bool) {
        apiKey = apikey
        baseUrl = euApi ? BASE_URL_EU : BASE_URL
        debugMode = debugmode
        manager = AFHTTPSessionManager()
    }
    
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

   public func executeGetEUapi(path: String, onSuccess successBlock:@escaping (_ id : AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/\(path)"
        debugLog(urlStr, params: nil)
        
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func createReport(_ formID: Int64, reportParams: [AnyHashable: Any], onSuccess successBlock: @escaping (_ id : AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "https://submit.jotform.com/submit/\(formID)/"
        debugLog(urlStr, params: reportParams)
     
        manager?.responseSerializer = AFHTTPResponseSerializer()
        
        manager?.post(urlStr, parameters: reportParams, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func createSuggestion(_ formID: Int64, suggestionParams: [AnyHashable: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "https://submit.jotform.me/submit/\(formID)/"
        debugLog(urlStr, params: suggestionParams)
       
        manager?.responseSerializer = AFHTTPResponseSerializer()
        
        manager?.post(urlStr, parameters: suggestionParams, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func login(_ userinfo: [AnyHashable: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/login"
        debugLog(urlStr, params: userinfo)
       
        manager?.post(urlStr, parameters: userinfo, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func logout(_ userinfo: [AnyHashable: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/logout?apiKey=\(apiKey)"
        debugLog(urlStr, params: userinfo)
        manager?.post(urlStr, parameters: userinfo, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func registerUser(_ userinfo: [AnyHashable: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/register?apiKey=\(apiKey)"
        debugLog(urlStr, params: userinfo)
       
          manager?.post(urlStr, parameters: userinfo, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func getUser(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func getForms(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/forms?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
       
         manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func getSubmissions(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/submissions?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
      
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func getSubusers(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/subusers?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
      
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func getFolders(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/users/folders?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
       
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func getFolder(_ folderID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/folder/\(folderID)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }

    public func getReports(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/reports/apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
      
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func deleteReport(_ reportID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/reports/\(reportID)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
       
        manager?.delete(urlStr, parameters: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func getSettings(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/settings?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func updateSettings(_ settings: [AnyHashable: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/settings?apiKey=\(apiKey)"
        debugLog(urlStr, params: settings)
        
        manager?.post(urlStr, parameters: settings, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func getHistory(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/history?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
       
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func getHistory(_ action: String, date: String, sortBy: String, startDate: String, endDate: String, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/history?apiKey=\(apiKey)"
        let params = createHistoryQuery(action, date: date, sortBy: sortBy, startDate: startDate, endDate: endDate)
        debugLog(urlStr, params: params)
        
        manager?.get(urlStr, parameters: params, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func getForm(_ formID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func getFormQuestions(_ formID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/questions?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
       
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func getFormQuestion(_ formID: Int64, questionID qid: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/question/\(qid)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func getFormSubmissions(_ formID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
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

    public func getFormSubmissions(_ formID: Int64, offset: Int, limit: Int, orderBy: String, filter: [AnyHashable: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/submissions?apiKey=\(apiKey)"
        let params = createConditions(offset, limit: limit, filter: filter, orderBy: orderBy)
        debugLog(urlStr, params: params)
      
        manager?.get(urlStr, parameters: params, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func getFormReports(_ formID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/reports?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func createFormSubmissions(_ formID: Int64, submission: [AnyHashable: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        var params = [AnyHashable: Any]()
        
        if let keys = Array(submission.keys) as? [String] {
          var subkey = ""
          for key: String in keys {
            if ((key as NSString).range(of: "_")).location != NSNotFound {
                subkey = "submission[\(String(describing: (key as NSString).substring(to: ((key as NSString).range(of: "_")).location)))][\(String(describing: (key as NSString).substring(to: (((key as NSString).range(of: "_")).location + 1))))]"
            }
            else {
                subkey = "submission[\(key)]"
            }
            if (submission[key] != nil) {
                params[subkey] = submission[key]
            }
          }
        }
        let urlStr = "\(baseUrl)/form/\(formID)/submissions?apiKey=\(apiKey)"
        debugLog(urlStr, params: params)
      
        manager?.post(urlStr, parameters: params, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func getFormFiles(_ formID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/files?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
       
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func getFormWebhooks(_ formID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/webhooks?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
       
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func createFormWebhooks(_ formID: Int64, hookUrl webhookURL: String, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        var params = [AnyHashable: Any]()
      
        if (webhookURL.count != 0) {
            params["webhookURL"] = webhookURL
        }
        
        let urlStr = "\(baseUrl)/form/\(formID)/webhooks?apiKey=\(apiKey)"
        debugLog(urlStr, params: params)
        
        manager?.post(urlStr, parameters: params, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func deleteWebhook(_ formID: Int64, webhookId webhookID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/forms/\(formID)/webhooks/\(webhookID)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
       
        manager?.delete(urlStr, parameters: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func getSubmission(_ sid: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/submission/\(sid)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
      
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func getReport(_ reportID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/report/\(reportID)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
      
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func createReport(_ formID: Int64, title: String, list_type: String, fields: String, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/reports?apiKey=\(apiKey)"
        var params = [AnyHashable: Any]()
        params["id"] = formID
        if title != "" {
            params["title"] = title
        }
        if list_type != "" {
            params["list_type"] = list_type
        }
        if fields != "" {
            params["fields"] = fields
        }
        debugLog(urlStr, params: params)
        
        manager?.post(urlStr, parameters: params, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }

    public func getFormProperties(_ formID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/properties?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
      
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }

    public func getFormProperty(_ formID: Int64, propertyKey: String, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/properties/\(propertyKey)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
      
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func checkEUserver(_ _apiKey: String, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        if let urlStr = "\(baseUrl)/user/settings/euOnly?apiKey=\(_apiKey)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            debugLog(urlStr, params: nil)
            
            manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
                successBlock(responseObject as AnyObject)
            }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
                failureBlock(error as Error)
            })
        }
    }
    
    public func deleteSubmission(_ sid: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/submission/\(sid)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
       
        manager?.delete(urlStr, parameters: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func editSubmission(_ sid: Int64, name submissionName: String, new: Int, flag: Int, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/submission/\(sid)?apiKey=\(apiKey)"
        var params = [AnyHashable: Any]()
        if submissionName != "" {
            params["submission[1][first]"] = submissionName
        }
        params["submission[new]"] = "\(new)"
        params["submission[flag]"] = "\(flag)"
        debugLog(urlStr, params: params)
        
        manager?.post(urlStr, parameters: params, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func cloneForm(_ formID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/clone?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
       
        manager?.post(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func deleteFormQuestion(_ formID: Int64, questionID qid: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/question/\(qid)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
       
        manager?.delete(urlStr, parameters: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func createFormQuestion(_ formID: Int64, question: [AnyHashable: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/questions?apiKey=\(apiKey)"
        var params = [AnyHashable: Any]()
       
        if let keys = Array(question.keys) as? [String] {
            for key: String in keys {
                params["question[\(key)]"] = question[key]
            }
        }
        
        debugLog(urlStr, params: params)
       
        manager?.post(urlStr, parameters: params, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func createFormQuestions(_ formID: Int64, questions: String, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/questions?apiKey=\(apiKey)"
        debugLog(urlStr, params: questions)
      
        manager?.put(urlStr, parameters: questions, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func editFormQuestion(_ formID: Int64, questionID qid: Int64, questionProperties properties: [AnyHashable: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/question/\(qid)?apiKey=\(apiKey)"
        var params = [AnyHashable: Any]()
        let keys: Array = Array(properties.keys)
       
        for key: String in keys as! [String] {
            params["question[\(key)]"] = properties[key]
        }
            
        debugLog(urlStr, params: params)
       
        manager?.post(urlStr, parameters: params, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func setFormProperties(_ formID: Int64, formProperties properties: [AnyHashable: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/properties?apiKey=\(apiKey)"
        var params = [AnyHashable: Any]()
        
        if let keys = Array(properties.keys) as? [String] {
            for key: String in keys {
                params["question[\(key)]"] = properties[key]
            }
        }
        
        debugLog(urlStr, params: params)
        
        manager?.post(urlStr, parameters: params, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }

    public func setMultipleFormProperties(_ formID: Int64, formProperties properties: String, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/properties?apiKey=\(apiKey)"
        debugLog(urlStr, params: properties)
      
        manager?.put(urlStr, parameters: properties, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func createForm(_ form: [AnyHashable: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        var params = [AnyHashable: Any]()
       
        if let formKeys: Array = Array(form.keys) as? [String] {
            for formKey: String in formKeys {
                if (formKey == "properties") {
                    var properties = form[formKey] as? [AnyHashable: Any]
                    let propertyKeys: Array = Array(properties!.keys)
                    
                    for propertyKey: String in propertyKeys as! [String] {
                        params["\(formKey)[\(propertyKey)]"] = properties?[propertyKey]
                    }
                }
                else {
                    var formItem = form[formKey] as? [AnyHashable: Any]
                    let formItemKeys: Array = Array(formItem!.keys)
                    for formItemKey: String in formItemKeys as! [String] {
                        var fi = formItem![formItemKey] as? [AnyHashable: Any]
                        
                        if let fiKeys: Array = Array(fi!.keys) as? [String] {
                            for fiKey: String in fiKeys {
                                params["\(formKey)[\(formItemKey)][\(fiKey)]"] = fi?[fiKey]
                            }
                        }
                    }
                }
            }
        }
        
        let urlStr = "\(baseUrl)/user/forms?apiKey=\(apiKey)"
        debugLog(urlStr, params: params)
      
        manager?.post(urlStr, parameters: params, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }

    public func createForms(_ form: [AnyHashable: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/forms?apiKey=\(apiKey)"
        debugLog(urlStr, params: form)
        
        manager?.put(urlStr, parameters: form, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }

    public func deleteForm(_ formID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/forms/\(formID)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
      
        manager?.delete(urlStr, parameters: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func getSystemPlan(_ planType: String, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/system/plan/\(planType)"
        debugLog(urlStr, params: nil)
       
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    public func getSystemTime(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/system/time"
        debugLog(urlStr, params: nil)
     
        manager?.get(urlStr, parameters: nil, progress: nil, success: {(_ task: URLSessionTask, _ responseObject: Any) -> Void in
            successBlock(responseObject as AnyObject)
        }, failure: {(_ operation: URLSessionDataTask?, _ error: Error) -> Void in
            failureBlock(error as Error)
        })
    }
    
    private func createHistoryQuery(_ action: String, date: String, sortBy: String, startDate: String, endDate: String) -> [AnyHashable: Any] {
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
    
    private func createConditions(_ offset: Int, limit: Int, filter: [AnyHashable: Any], orderBy: String) -> [AnyHashable: Any] {
        var params = [AnyHashable: Any]()
        
        if offset != 0 {
            params["offset"] = offset
        }
        
        if limit != 0 {
            params["limit"] = limit
        }
        
        if (filter.isEmpty) {
            var filterStr = "%7B"
            var count: Int = 0
            let set = CharacterSet.urlHostAllowed
            
            if let keys = Array(filter.keys) as? [String] {
                for key: String in keys{
                    if let filterArray = filter[key] as? [String] {
                        filterStr = filterStr + ("%%22\(key)%%22%%3A%%5B")
                        
                        for value: String in filterArray {
                            filterStr = filterStr + ("%%22\(String(describing: value.addingPercentEncoding(withAllowedCharacters: `set`)))%%22")
                            if filterArray.last != value {
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


