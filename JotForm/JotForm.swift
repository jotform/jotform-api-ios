//
//  JotForm.swift
//  JotForm_iOS
//
//  Created by Curtis Stilwell on 1/21/18.
//  Copyright © 2018 Interlogy, LLC. All rights reserved.
//

import Alamofire

public class JotForm: NSObject {
    private var apiKey = ""
    private var baseUrl = ""
    private var debugMode = false
    
    let BASE_URL = "https://api.jotform.com"
    let BASE_URL_EU = "https://eu-api.jotform.com"
    
    public init(apiKey apikey: String, debugMode debugmode: Bool, euApi: Bool) {
        apiKey = apikey
        baseUrl = euApi ? BASE_URL_EU : BASE_URL
        debugMode = debugmode
    }
    
    func debugLog(_ urlStr: String, params: Any?) {
        if debugMode {
            var paramsStr = ""
            
            if params is String {
                paramsStr = params as? String ?? ""
            } else if params is [String: Any] {
                paramsStr = (params as AnyObject).description
            }
            
            print("urlstr = \(urlStr)")
            
            if  paramsStr.count > 0 {
                print("paramstr = \(paramsStr)")
            }
        }
    }
    
    public func executeGetEUapi(path: String, onSuccess successBlock:@escaping (_ id : AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/\(path)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func createReport(_ formID: Int64, reportParams: [String: Any], onSuccess successBlock: @escaping (_ id : AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "https://submit.jotform.com/submit/\(formID)/"
        debugLog(urlStr, params: reportParams)
        
        Alamofire.request(urlStr, method: .post, parameters: reportParams, encoding:URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func createSuggestion(_ formID: Int64, suggestionParams: [String: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "https://submit.jotform.me/submit/\(formID)/"
        debugLog(urlStr, params: suggestionParams)
        
        Alamofire.request(urlStr, method: .post, parameters: suggestionParams, encoding:URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func login(_ userinfo: [String: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/login"
        debugLog(urlStr, params: userinfo)
        
        Alamofire.request(urlStr, method: .post, parameters: userinfo, encoding: URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func logout(_ userinfo: [String: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/logout?apiKey=\(apiKey)"
        debugLog(urlStr, params: userinfo)
        
        Alamofire.request(urlStr, method: .post, parameters: userinfo, encoding:URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func registerUser(_ userinfo: [String: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/register?apiKey=\(apiKey)"
        debugLog(urlStr, params: userinfo)
        
        Alamofire.request(urlStr, method: .post, parameters: userinfo, encoding:URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getUser(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getForms(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/forms?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody , headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getForms(_ offset: Int, limit: Int, orderBy: String, filter: [String: AnyObject]?, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/forms?apiKey=\(apiKey)"
        let params = createConditions(offset, limit: limit, filter: filter, orderBy: orderBy)
        debugLog(urlStr, params: params)
        
        Alamofire.request(urlStr, method: .get, parameters: params, encoding:URLEncoding.httpBody , headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getSubmissions(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/submissions?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getSubmissions(_ offset: Int, limit: Int, orderBy: String, filter: [String: AnyObject]?, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/submissions?apiKey=\(apiKey)"
        let params = createConditions(offset, limit: limit, filter: filter, orderBy: orderBy)

        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: params, encoding:URLEncoding.httpBody , headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getSubusers(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/subusers?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody , headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getFolders(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/users/folders?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody , headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getFolder(_ folderID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/folder/\(folderID)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody , headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getReports(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/reports/apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody , headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func deleteReport(_ reportID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/reports/\(reportID)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .delete, parameters: nil, encoding:URLEncoding.httpBody , headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getSettings(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/settings?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody , headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func updateSettings(_ settings: [String: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/settings?apiKey=\(apiKey)"
        debugLog(urlStr, params: settings)
        
        Alamofire.request(urlStr, method: .post, parameters:settings, encoding:URLEncoding.httpBody , headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getHistory(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/history?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody , headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getHistory(_ action: String, date: String, sortBy: String, startDate: String, endDate: String, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/history?apiKey=\(apiKey)"
        let params = createHistoryQuery(action, date: date, sortBy: sortBy, startDate: startDate, endDate: endDate)
        debugLog(urlStr, params: params)
        
        Alamofire.request(urlStr, method: .get, parameters: params, encoding:URLEncoding.httpBody , headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getForm(_ formID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody , headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getFormQuestions(_ formID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/questions?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody , headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getFormQuestion(_ formID: Int64, questionID qid: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/question/\(qid)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody , headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getFormSubmissions(_ formID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/submissions?apiKey=\(apiKey)"
        var params: [String: Any] = [:]
        params["qid_enabled"] = "true"
        debugLog(urlStr, params: params)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody , headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getFormSubmissions(_ formID: Int64, offset: Int, limit: Int, orderBy: String, filter: [String: AnyObject], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/submissions?apiKey=\(apiKey)"
        let params = createConditions(offset, limit: limit, filter: filter, orderBy: orderBy)
        debugLog(urlStr, params: params)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody , headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getFormReports(_ formID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/reports?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody , headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func createFormSubmissions(_ formID: Int64, submission: [String: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        var params: [String: Any] = [:]
        var subkey = ""
        for key: String in submission.keys {
            if (key as NSString).range(of: "_").location != NSNotFound {
                subkey = "submission[\(String(describing: (key as NSString).substring(to: ((key as NSString).range(of: "_")).location)))][\(String(describing: (key as NSString).substring(to: (((key as NSString).range(of: "_")).location + 1))))]"
            } else {
                subkey = "submission[\(key)]"
            }
            if  submission[key] != nil {
                params[subkey] = submission[key]
            }
        }
        
        let urlStr = "\(baseUrl)/form/\(formID)/submissions?apiKey=\(apiKey)"
        debugLog(urlStr, params: params)
        
        Alamofire.request(urlStr, method: .post, parameters:params, encoding:URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getFormFiles(_ formID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/files?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody , headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getFormWebhooks(_ formID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/webhooks?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody , headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func createFormWebhooks(_ formID: Int64, hookUrl webhookURL: String, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        var params: [String: Any] = [:]
        
        if  webhookURL.count != 0 {
            params["webhookURL"] = webhookURL
        }
        
        let urlStr = "\(baseUrl)/form/\(formID)/webhooks?apiKey=\(apiKey)"
        debugLog(urlStr, params: params)
        
        Alamofire.request(urlStr, method: .post, parameters: params, encoding:URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func deleteWebhook(_ formID: Int64, webhookId webhookID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/forms/\(formID)/webhooks/\(webhookID)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .delete, parameters: nil, encoding:URLEncoding.httpBody , headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getSubmission(_ sid: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/submission/\(sid)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody , headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getReport(_ reportID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/report/\(reportID)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func createReport(_ formID: Int64, title: String, list_type: String, fields: String, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/reports?apiKey=\(apiKey)"
        var params: [String: Any] = [:]
        
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
        
        Alamofire.request(urlStr, method: .post, parameters: params, encoding:URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getFormProperties(_ formID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/properties?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody , headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getFormProperty(_ formID: Int64, propertyKey: String, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/properties/\(propertyKey)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func checkEUserver(_ _apiKey: String, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/settings/euOnly?apiKey=\(_apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func deleteSubmission(_ sid: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/submission/\(sid)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .delete, parameters: nil, encoding: URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func editSubmission(_ sid: Int64, name submissionName: String, new: Int, flag: Int, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/submission/\(sid)?apiKey=\(apiKey)"
        var params: [String: Any] = [:]
       
        if submissionName != "" {
            params["submission[1][first]"] = submissionName
        }
       
        params["submission[new]"] = "\(new)"
        params["submission[flag]"] = "\(flag)"
       
        debugLog(urlStr, params: params)
        
        Alamofire.request(urlStr, method: .post, parameters: params, encoding:URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func cloneForm(_ formID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/clone?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .post, parameters:nil, encoding:URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func deleteFormQuestion(_ formID: Int64, questionID qid: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/question/\(qid)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .delete, parameters: nil, encoding: URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func createFormQuestion(_ formID: Int64, question: [String: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/questions?apiKey=\(apiKey)"
        var params: [String: Any] = [:]
        
        for key: String in question.keys {
            params["question[\(key)]"] = question[key]
        }
        
        debugLog(urlStr, params: params)
        
        Alamofire.request(urlStr, method: .post, parameters: params, encoding:URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func createFormQuestions(_ formID: Int64, questions: String, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/questions?apiKey=\(apiKey)"
        debugLog(urlStr, params: questions)
        
        Alamofire.request(urlStr, method: .put, parameters: nil, encoding: URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func editFormQuestion(_ formID: Int64, questionID qid: Int64, questionProperties properties: [String: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/question/\(qid)?apiKey=\(apiKey)"
        var params: [String: Any] = [:]
        let keys = Array(properties.keys)
        
        for key: String in keys {
            params["question[\(key)]"] = properties[key]
        }
        
        debugLog(urlStr, params: params)
        
        Alamofire.request(urlStr, method: .post, parameters: params, encoding:URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func setFormProperties(_ formID: Int64, formProperties properties: [String: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/properties?apiKey=\(apiKey)"
        var params: [String: Any] = [:]
        
        for key: String in properties.keys {
            params["question[\(key)]"] = properties[key]
        }
        
        debugLog(urlStr, params: params)
        
        Alamofire.request(urlStr, method: .post, parameters: params, encoding:URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func setMultipleFormProperties(_ formID: Int64, formProperties properties: String, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/form/\(formID)/properties?apiKey=\(apiKey)"
        debugLog(urlStr, params: properties)
        
        Alamofire.request(urlStr, method: .put, parameters: nil, encoding:URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func createForm(_ form: [String: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        var params: [String: Any] = [:]
        
        for formKey in form.keys {
            if formKey == "properties" {
                var properties = form[formKey] as? [String: Any]
                let propertyKeys = Array(properties!.keys)
                
                for propertyKey in propertyKeys {
                    params["\(formKey)[\(propertyKey)]"] = properties?[propertyKey]
                }
            } else {
                var formItem = form[formKey] as? [String: Any]
                let formItemKeys = Array(formItem!.keys)
                for formItemKey in formItemKeys {
                    var fi = formItem![formItemKey] as? [String: Any]
                    
                    for fiKey in fi!.keys {
                        params["\(formKey)[\(formItemKey)][\(fiKey)]"] = fi?[fiKey]
                        
                    }
                }
            }
            
            let urlStr = "\(baseUrl)/user/forms?apiKey=\(apiKey)"
            debugLog(urlStr, params:params)
            
            Alamofire.request(urlStr, method: .post, parameters: params, encoding:URLEncoding.httpBody, headers: nil).responseJSON { response in
                switch(response.result) {
                case .success(let data):
                    successBlock(data as AnyObject)
                    break
                case .failure(let error):
                    failureBlock(error as Error)
                    break
                }
            }
        }
    }
    
    public func createForms(_ form: [String: Any], onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/user/forms?apiKey=\(apiKey)"
        debugLog(urlStr, params:form)
        
        Alamofire.request(urlStr, method: .put, parameters: nil, encoding:URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func deleteForm(_ formID: Int64, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/forms/\(formID)?apiKey=\(apiKey)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .delete, parameters: nil, encoding:URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getSystemPlan(_ planType: String, onSuccess successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/system/plan/\(planType)"
        debugLog(urlStr, params: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    public func getSystemTime(_ successBlock: @escaping (_ id: AnyObject) -> Void, onFailure failureBlock: @escaping (_: Error) -> Void) {
        let urlStr = "\(baseUrl)/system/time"
        debugLog(urlStr, params:nil)
        
        Alamofire.request(urlStr, method: .get, parameters: nil, encoding:URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let data):
                successBlock(data as AnyObject)
                break
            case .failure(let error):
                failureBlock(error as Error)
                break
            }
        }
    }
    
    private func createHistoryQuery(_ action: String, date: String, sortBy: String, startDate: String, endDate: String) -> [String: Any] {
        var params: [String: Any] = [:]
        
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
    
    private func createConditions(_ offset: Int, limit: Int, filter: [String: AnyObject]?, orderBy: String) -> [String: Any] {
        var params: [String: Any] = [:]
        
        if offset != 0 {
            params["offset"] = offset
        }
        
        if limit != 0 {
            params["limit"] = limit
        }
        
        if let filter = filter as [String: AnyObject]? {
            if filter.isEmpty {
                var filterStr = "%7B"
                var count = 0
                let set = CharacterSet.urlHostAllowed
                
                for key: String in filter.keys {
                    if let array = filter[key] as? [String] {
                        filterStr = filterStr + ("%%22\(key)%%22%%3A%%5B")
                        
                        for value: String in array {
                            filterStr = filterStr + ("%%22\(String(describing: value.addingPercentEncoding(withAllowedCharacters: `set`)))%%22")
                            if array.last != value {
                                filterStr = filterStr + ("%2C")
                            }
                        }
                        filterStr = filterStr + ("%5D")
                    } else {
                        if let string = filter[key] as? String {
                            filterStr = filterStr + ("%%22\(key)%%22%%3A%%22\(String(describing: string.addingPercentEncoding(withAllowedCharacters: `set`)))%%22")
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
        }
        if  orderBy.count != 0 {
            params["orderyBy"] = orderBy
        }
        return params
    }
}


