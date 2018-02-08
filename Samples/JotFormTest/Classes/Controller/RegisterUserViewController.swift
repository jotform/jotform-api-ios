//
//  RegisterUserViewController.swift
//  JotFormTest
//
//  Created by Curtis Stilwell on 2/4/18.
//  Copyright © 2018 wang. All rights reserved.
//

import Foundation

class RegisterUserViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        title = "Register user"
    }
    
    func registerUser() {
        if  usernameTextField.text?.count == 0 {
            usernameTextField.becomeFirstResponder()
            return
        }
       
        if passwordTextField.text?.count == 0 {
            passwordTextField.becomeFirstResponder()
            return
        }
        
        if emailTextField.text?.count == 0 {
           emailTextField.becomeFirstResponder()
           return
        }
        
        SVProgressHUD.show(withStatus: "Registering user...")
        
        var userInfo = [String: Any]()
        userInfo["username"] = usernameTextField.text
        userInfo["password"] = passwordTextField.text
        userInfo["email"] = emailTextField.text
        
        SharedData.sharedData.apiClient?.registerUser(userInfo, onSuccess: {(_ result: Any) -> Void in
            SVProgressHUD.dismiss()
            
            let alertView = UIAlertController(title: "JotFormAPISample", message: "You registered new user successfully.", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Ok", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            })
            alertView.addAction(cancelButton)
            self.present(alertView, animated: true, completion: nil)
            
        }, onFailure: {(_ error: Any) -> Void in
            SVProgressHUD.dismiss()
        })
    }
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        registerUser()
    }
}
