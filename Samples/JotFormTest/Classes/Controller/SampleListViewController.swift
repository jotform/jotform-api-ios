//
//  SampleListViewController.swift
//  JotFormTest
//
//  Created by Curtis Stilwell on 1/31/18.
//  Copyright © 2018 wang. All rights reserved.
//

import Foundation

class SampleListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    override func viewDidLoad() {
        // Do any additional setup after loading the view from its nib.
        title = "API sample list"
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
        return SharedData().sampleStrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "SampleCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "SampleCell")
        }
        let sampleStr: String = SharedData().sampleStrList[indexPath.row]
        cell?.textLabel?.text = sampleStr
        cell?.textLabel?.textColor = UIColor.darkGray
        cell?.selectionStyle = .blue
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let getAllFormsVc = GetAllFormsViewController(nibName: "GetAllFormsViewController", bundle: nil)
            
            navigationController?.pushViewController(getAllFormsVc, animated: true)
        }
    }
}
