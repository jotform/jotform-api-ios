//
//  CreateQuestionViewController.swift
//  JotFormTest
//
//  Created by Curtis Stilwell on 2/5/18.
//  Copyright © 2018 wang. All rights reserved.
//

import Foundation

class CreateQuestionViewController: UIViewController {
    
    func createFormQuestion() {
        if FORM_ID == 0 {
            let alertView = UIAlertController(title: "JotFormAPISample", message: "Please put Form's id in line 23", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Ok", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            })
            alertView.addAction(cancelButton)
            present(alertView, animated: true) {() -> Void in }
            return
        }
        
        var question = [String: Any]()
        question["type"] = "control_textbox"
        question["text"] = "New Text"
        question["order"] = "1"
        question["1"] = "New Name of Question"
        
        SharedData.sharedData.apiClient?.createFormQuestion(FORM_ID, question: question, onSuccess: {(_ result: AnyObject) -> Void in
            SVProgressHUD.dismiss()
            let responseCode: Int = result["responseCode"]  as! Int
            
            if responseCode == 200 || responseCode == 206 {
                let alertView = UIAlertController(title: "JotFormAPISample", message: "You created question successfully.", preferredStyle: .alert)
                let cancelButton = UIAlertAction(title: "Ok", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                })
                alertView.addAction(cancelButton)
               self.present(alertView, animated: true, completion: nil)
            }
            
        }, onFailure: {(_ error: Any) -> Void in
            SVProgressHUD.dismiss()
        })
    }
}
