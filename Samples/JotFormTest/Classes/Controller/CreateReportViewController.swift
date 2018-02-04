//
//  CreateReportViewController.swift
//  JotFormTest
//
//  Created by Curtis Stilwell on 2/4/18.
//  Copyright © 2018 wang. All rights reserved.
//

import Foundation

class CreateReportViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        title = "Create report"
    }
    
    func createReport() {
        if FORM_ID == 0 {
            let alertView = UIAlertController(title: "JotFormAPISample", message: "Please put Form's id in line 22, Common.h", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Ok", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            })
            alertView.addAction(cancelButton)
            present(alertView, animated: true) {() -> Void in }
            return
        }
        
        SharedData.sharedData.apiClient?.createReport(FORM_ID, title: "Test Report", list_type: "csv", fields: "date", onSuccess: {(_ result: AnyObject) -> Void in
            SVProgressHUD.dismiss()
           
            let responseCode: Int = result["responseCode"]  as! Int
            
            if responseCode == 200 || responseCode == 206 {
              
                let alertView = UIAlertController(title: "JotFormAPISample", message: "You created report successfully.", preferredStyle: .alert)
               
                let cancelButton = UIAlertAction(title: "Ok", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                })
               
                alertView.addAction(cancelButton)
                self.present(alertView, animated: true, completion: nil)
            }
        },onFailure: {(_ error: Any) -> Void in
            SVProgressHUD.dismiss()
        })
    }
}
