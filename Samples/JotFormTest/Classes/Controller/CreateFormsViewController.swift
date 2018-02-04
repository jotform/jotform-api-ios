//
//  CreateFormsViewController.swift
//  JotFormTest
//
//  Created by Curtis Stilwell on 2/4/18.
//  Copyright © 2018 wang. All rights reserved.
//

import Foundation

class CreateFormsViewController: UIViewController {
    func createForms() {
        let objectData: Data? = "{\"questions\":[{\"type\":\"control_head\"}]}".data(using: .utf8)
        let json = (try? JSONSerialization.jsonObject(with: objectData ?? Data(), options: .mutableContainers)) as? [String: Any]
      
        SharedData.sharedData.apiClient?.createForms(json!, onSuccess: {(_ result: Any) -> Void in
        }, onFailure: {(_ error: Error?) -> Void in
        })
    }
    
    @IBAction func createFormsViewClicked(_ sender: Any) {
        createForms()
    }
}
