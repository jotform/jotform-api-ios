//
//  CreateFormQuestionsViewController.swift
//  JotFormTest
//
//  Created by Curtis Stilwell on 2/5/18.
//  Copyright © 2018 wang. All rights reserved.
//

import Foundation

class CreateFormQuestionsViewController: UIViewController {
    func createFormQuestions() {
        let jsonString = "{\"questions\":{\"1\":{\"type\":\"control_head\",\"text\":\"Text 1\",\"order\":\"1\",\"name\":\"Header1\"},\"2\":{\"type\":\"control_head\",\"text\":\"Text 2\",\"order\":\"2\",\"name\":\"Header2\"}}}"
        
        SharedData.sharedData.apiClient?.createFormQuestions(FORM_ID, questions: jsonString, onSuccess: {(_ result: AnyObject) -> Void in
            SVProgressHUD.dismiss()
            
            if let responseCode: Int = result["responseCode"]  as? Int {
                if responseCode == 200 || responseCode == 206 {
                    let alertView = UIAlertController(title: "JotFormAPISample", message: "You created question successfully.", preferredStyle: .alert)
                    let cancelButton = UIAlertAction(title: "Ok", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                    })
                    alertView.addAction(cancelButton)
                    self.present(alertView, animated: true, completion: nil)
                }
            }
            
        }, onFailure: {(_ error: Any) -> Void in
            SVProgressHUD.dismiss()
        })
    }

    @IBAction func createFormQuestionsClicked(_ sender: Any) {
        createFormQuestions()
    }
}
