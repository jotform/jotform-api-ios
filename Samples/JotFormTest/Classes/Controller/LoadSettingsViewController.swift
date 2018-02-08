//
//  LoadSettingsViewController.swift
//  JotFormTest
//
//  Created by Curtis Stilwell on 2/4/18.
//  Copyright © 2018 wang. All rights reserved.
//

import Foundation

class LoadSettingsViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        title = "Load Settings"
        loadSettings()
    }
    
    func loadSettings() {
        SharedData.sharedData.apiClient?.getSettings({(_ result: Any) -> Void in
            self.textView.text = "\(result)"
        }, onFailure: {(_ error: Error?) -> Void in
        })
    }
}
