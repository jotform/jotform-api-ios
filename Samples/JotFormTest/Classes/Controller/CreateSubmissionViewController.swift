//
//  CreateSubmissionViewController.swift
//  JotFormTest
//
//  Created by Curtis Stilwell on 2/4/18.
//  Copyright © 2018 wang. All rights reserved.
//

import Foundation

class CreateSubmissionViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        title = "Create submission"
    }
    
    func createSubmission() {
        SVProgressHUD.show(withStatus: "Creating submissions...")
        var submission = [String:Any]()
        submission["1"] = "XXX"
        submission["2"] = "This is a test for creating submission."
        
        SharedData.sharedData.apiClient?.createFormSubmissions(FORM_ID, submission: submission, onSuccess: {(_ result: Any) -> Void in
            SVProgressHUD.dismiss()
            
            let alertView = UIAlertController(title: "JotFormAPISample", message: "You created submission successfully", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Ok", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            })
            
            alertView.addAction(cancelButton)
            self.present(alertView, animated: true, completion: nil)
            
        }, onFailure: {(_ error: Any) -> Void in
            SVProgressHUD.dismiss()
        })
    }
    
    @IBAction func createSubmissionButtonClicked(_ sender: Any) {
        createSubmission()
    }
    
}
