//
//  GetFormPropertiesViewController.swift
//  JotFormTest
//
//  Created by Curtis Stilwell on 2/4/18.
//  Copyright © 2018 wang. All rights reserved.
//

import Foundation

class GetFormPropertiesViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view from its nib.
        SharedData.sharedData.apiClient?.getFormProperties(FORM_ID, onSuccess: {(_ result: Any) -> Void in
            self.textView.text = "\(result)"
        }, onFailure: {(_ error: Error?) -> Void in
        })
    }
}
