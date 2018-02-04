//
//  CreateFormViewController.swift
//  JotFormTest
//
//  Created by Curtis Stilwell on 2/4/18.
//  Copyright © 2018 wang. All rights reserved.
//

import Foundation

class CreateFormViewController: UIViewController {
    override func viewDidLoad() {
        // Do any additional setup after loading the view from its nib.
        title = "Create form"
    }
    
    @IBAction func createFormButtonClicked(_ sender: Any) {
        SVProgressHUD.show(withStatus: "Creating form...")
        // create form using JotformAPI client
        var properties = [AnyHashable: Any]()
        properties["title"] = "Test Form"
        
        var questions = [AnyHashable: Any]()
        var questionItem = [AnyHashable: Any]()
        questionItem["type"] = "control_textbox"
        questionItem["text"] = "Name"
        questionItem["order"] = "1"
        questionItem["1"] = "textboxName"
        questions["1"] = questionItem
        questionItem = [AnyHashable: Any]()
        questionItem["type"] = "control_textarea"
        questionItem["text"] = "Message"
        questionItem["order"] = "2"
        questionItem["name"] = "textboxMessage"
        questions["2"] = questionItem
        
        var form = [String: Any]()
        form["properties"] = properties
        form["questions"] = questions
        
        SharedData.sharedData.apiClient?.createForm(form, onSuccess: { (_ result: AnyObject) in
            
            let responseCode: Int = result["responseCode"]  as! Int
            
            if (responseCode == 200 || responseCode == 206) {
                let alertView = UIAlertController(title: "JotFormAPISample", message: "You created submission successfully", preferredStyle: .alert)
                let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                })
                
                alertView.addAction(cancelButton)
                self.present(alertView, animated: true, completion: nil)
                
            }
            
             SVProgressHUD.dismiss()
            
        }, onFailure: { (_ error: Any) in
            SVProgressHUD.dismiss()
        })
    }
}

