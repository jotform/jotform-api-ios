//
//  CreateFormPropertiesViewController.swift
//  JotFormTest
//
//  Created by Curtis Stilwell on 2/4/18.
//  Copyright © 2018 wang. All rights reserved.
//

import Foundation

class CreateFormPropertiesViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view from its nib.
        title = "Create Form Properties"
       
    }
    
    @IBAction func createFormPropertiesClicked(_ sender: Any) {
        var userInfo = [String: Any]()
        userInfo["350"] = "properties[formWidth]"
        
        SharedData.sharedData.apiClient?.setFormProperties(FORM_ID, formProperties: userInfo, onSuccess: {(_ result: Any) -> Void in
        }, onFailure: {(_ error: Error?) -> Void in
        })
    }
}
