//
//  DataListViewController.swift
//  JotFormTest
//
//  Created by Curtis Stilwell on 2/1/18.
//  Copyright © 2018 wang. All rights reserved.
//

import Foundation

class DataListViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    var listType = DataListType(rawValue: 0)
    var dataList = [AnyHashable]()
    
    
    public func setList(_ dataArray:[AnyObject], type: DataListType) {
        listType = type
        dataList = dataArray as! [AnyHashable]
        listTableView.reloadData()
        
        switch listType {
        case .formList?:
            title = "Form list"
        case .submissionList?:
            title = "Submission list"
        default:
            title = "Report list"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "SampleCell")
        
        if !(cell != nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "SampleCell")
        }
        
        cell?.selectionStyle = .none
        var object = dataList[indexPath.row] as? [AnyHashable : Any]
        cell?.detailTextLabel?.text = object!["id"] as? String
        
        if listType == DataListType.formList || listType == DataListType.reportList {
            cell?.textLabel?.text = object!["title"] as? String
        }
        cell?.textLabel?.textColor = UIColor.darkGray

        return cell!
    }
}
