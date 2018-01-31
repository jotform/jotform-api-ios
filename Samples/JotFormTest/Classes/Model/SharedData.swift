//
//  SharedData.swift
//  JotFormTest
//
//  Created by Curtis Stilwell on 1/31/18.
//  Copyright © 2018 wang. All rights reserved.
//

import Foundation
import JotForm_iOS

var sampleStrList = [Any]()
var apiClient: JotForm?

let sharedData = SharedData()

class SharedData {
    init() {
        initSharedData()
    }
    
    func initSharedData() {
        let sampleStr = "Get all forms,Get all submissions,Get all reports,Create form,Create submission,Create report,Register user,Create question,Load settings,Get history,Get form properties,Create form properties,Create Forms,Create Form Questions"
        sampleStrList = (sampleStr.components(separatedBy: ","))
    }
    
    func initAPIClient(_ apiKey: String, euApi: Bool) {
        apiClient = JotForm(apiKey: apiKey, debugMode: true, euApi: euApi)
    }
    
    func getFormOrderbyList() -> [Any] {
        let orderbyStr = "id,username,title,status,created_at,updated_at,new,count,slug"
        let orderbyList = orderbyStr.components(separatedBy: ",")
        return orderbyList
    }
}
