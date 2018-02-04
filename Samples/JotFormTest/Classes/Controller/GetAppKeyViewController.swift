//
//  GetAppKeyViewController.swift
//  JotFormTest
//
//  Created by Curtis Stilwell on 1/31/18.
//  Copyright © 2018 wang. All rights reserved.
//

import UIKit
import Foundation
import JotForm_iOS

class GetAppKeyViewController: UIViewController {
    var apiClient: JotForm?
    
    @IBOutlet weak var usernameTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        apiClient = JotForm(apiKey: "", debugMode: false, euApi: false)
      
        title = "Get App Key"
        showAlertView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        usernameTextField?.text = ""
        passwordTextField?.text = ""
    }
    
    func showSampleListViewController() {
         let sampleListVc = SampleListViewController(nibName: "SampleListViewController", bundle: nil)
        navigationController?.pushViewController(sampleListVc, animated: true)
    }
    
    func showAlertView() {
        let alertView = UIAlertController(title: "JotFormAPISample", message: "Do you have an API key?", preferredStyle: .alert)
        
        let yesButton = UIAlertAction(title: "Yes", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            if (API_KEY == "") {
                let alertViewCancel = UIAlertController(title: "JotFormAPISample", message: "Please put your API key in Common.h.", preferredStyle: .alert)
                
                let cancelButton = UIAlertAction(title: "Ok", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                })
                
                alertViewCancel.addAction(cancelButton)
                self.present(alertViewCancel, animated: true, completion: nil)
            } else {
                SharedData().initAPIClient(API_KEY, euApi: EU_API)
                self.showSampleListViewController()
            }
        })
        
        let noButton = UIAlertAction(title: "No", style: .default, handler: {(_ action: UIAlertAction) -> Void in
        })
        
        alertView.addAction(yesButton)
        alertView.addAction(noButton)
        self.present(alertView, animated: true, completion: nil)
    }
    
    @IBAction func getAppKeyButtonClicked(_ sender: Any) {
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
        
        usernameTextField?.resignFirstResponder()
        passwordTextField?.resignFirstResponder()
        
        SVProgressHUD.show(withStatus: "Getting app key...")
        
        var userInfo = [String: Any]()
        userInfo["username"] = usernameTextField?.text
        userInfo["password"] = passwordTextField?.text
        userInfo["appName"] = "JotFormAPISample"
        userInfo["access"] = "full"

        apiClient?.login(userInfo, onSuccess: {(_ result: AnyObject) -> Void in
            let responseCode: Int = result["responseCode"]  as! Int
            if responseCode == 200 || responseCode == 206 {
                let content = result["content"] as AnyObject
                let appKey = content["appKey"] as! String
                self.checkEuServer(appKey)
            } else {
                 SVProgressHUD.dismiss()
            }
        }, onFailure: {(_ error: Any) -> Void in
            SVProgressHUD.dismiss()
        })
    }
    
    func checkEuServer(_ appKey: String) {
        apiClient?.checkEUserver(appKey, onSuccess: {(_ result: AnyObject) -> Void in
            SVProgressHUD.dismiss()
         
            let content = result["content"] as AnyObject
            
            let isEuServer: Bool
            
            if let string = content["euOnly"] as? String {
                isEuServer = (Int(string) ?? 0) != 0
            } else {
                isEuServer = content["euOnly"] as! Bool
            }
            
            SharedData.sharedData.initAPIClient(appKey, euApi:isEuServer)
            
            self.showSampleListViewController()
        }, onFailure: {(_ error: Error?) -> Void in
            SVProgressHUD.dismiss()
        })
    }
}
