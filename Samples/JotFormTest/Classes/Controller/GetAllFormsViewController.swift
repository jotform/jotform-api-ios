//
//  GetAllFormsViewController.swift
//  JotFormTest
//
//  Created by Curtis Stilwell on 2/1/18.
//  Copyright © 2018 wang. All rights reserved.
//

import Foundation

class GetAllFormsViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource {
    var orderbyList = [Any]()
    var sharedData: SharedData?
    
    @IBOutlet weak var offsetTextField: UITextField!
    @IBOutlet weak var limitTextField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var filterTextField: UITextField!
    @IBOutlet weak var getBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        initData()
        initUI()
    }
    
    func initUI() {
        title = "Get all forms"
        navigationItem.rightBarButtonItem = getBarButtonItem
    }
    
    func initData() {
        orderbyList = SharedData().getFormOrderbyList()
    }
    
    func loadForms() {
        SVProgressHUD.show(withStatus: "Loading forms...")
        
        var offset: Int = 0
        var limit: Int = 0
       
        if offsetTextField.text!.count > 0 {
            offset = Int(offsetTextField.text!)!
        }
       
        if limitTextField.text!.count > 0 {
            limit = Int(limitTextField.text!)!
        }
        
        let orderby: String = orderbyList[pickerView.selectedRow(inComponent: 0)] as! String
        
        SharedData.sharedData.apiClient?.getForms(offset, limit: limit, orderBy: orderby, filter:nil, onSuccess: {(_ result: AnyObject) -> Void in
            SVProgressHUD.dismiss()
             let responseCode = result["responseCode"] as? Int
           
            if responseCode == 200 || responseCode == 206 {
                let formsArray = result["content"] as? [AnyObject]
                self.startDataListViewController(formsArray!)
            }
            
        }, onFailure: {(_ error: Any) -> Void in
            SVProgressHUD.dismiss()
        })
    }
    
    func startDataListViewController(_ datalist: [Any]) {
        let dataListVc = DataListViewController(nibName: "DataListViewController", bundle: nil)
        navigationController?.pushViewController(dataListVc, animated: true)
        dataListVc.setList(datalist as [AnyObject], type:DataListType.formList)
    }
    
    @IBAction func getFormsButtonClicked(_ sender: Any) {
        loadForms()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return orderbyList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let rowStr: String = orderbyList[row] as! String
        return rowStr
    }
}
