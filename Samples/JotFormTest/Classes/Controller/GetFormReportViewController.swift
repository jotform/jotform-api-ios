//
//  GetFormReportViewController.swift
//  JotFormTest
//
//  Created by Curtis Stilwell on 2/4/18.
//  Copyright © 2018 wang. All rights reserved.
//

import Foundation

class GetFormReportsViewController: UIViewController {
    override func viewDidLoad() {
        // Do any additional setup after loading the view from its nib.
        title = "Create form"
    }
    
    func startDataListViewController(_ reportList: [Any]) {
        let dataListVc = DataListViewController(nibName: "DataListViewController", bundle: nil)
        navigationController?.pushViewController(dataListVc, animated: true)
        dataListVc.setList(reportList as [AnyObject], type:DataListType.reportList)
    }
   
    @IBAction func getFormReportsButtonClicked(_ sender: Any) {
        if FORM_ID == 0 {
            let alertView = UIAlertController(title: "JotFormAPISample", message: "Please put Form's id in line 19, Common.h", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Ok", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            })
            alertView.addAction(cancelButton)
            present(alertView, animated: true) {() -> Void in }
        } else {
            SVProgressHUD.show(withStatus: "Loading reports...")
            SharedData.sharedData.apiClient?.getFormReports(FORM_ID, onSuccess: {(_ result: AnyObject) -> Void in
                if let responseCode: Int = result["responseCode"]  as? Int {
                    if (responseCode == 200 || responseCode == 206) {
                        if let reportsArray = result["content"] as? [String] {
                            self.startDataListViewController(reportsArray)
                        }
                    }
                }
                  SVProgressHUD.dismiss()
            }, onFailure: {(_ error: Any) -> Void in
                 SVProgressHUD.dismiss()
            })
          }
        }
    }

