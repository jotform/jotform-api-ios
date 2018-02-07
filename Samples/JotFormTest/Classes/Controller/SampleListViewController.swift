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
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SampleCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SampleCell", for: indexPath)
        
        let sampleStr: String = SharedData().sampleStrList[indexPath.row]
        cell.textLabel?.text = sampleStr
        cell.textLabel?.textColor = UIColor.darkGray
        cell.selectionStyle = .blue
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let getAllFormsVc = GetAllFormsViewController(nibName: "GetAllFormsViewController", bundle: nil)
            
            navigationController?.pushViewController(getAllFormsVc, animated: true)
        } else if indexPath.row == 1 {
            let getAllSubmissionsVc = GetAllSubmissionsViewController(nibName: "GetAllSubmissionsViewController", bundle: nil)
            
            navigationController?.pushViewController(getAllSubmissionsVc, animated: true)
        } else if indexPath.row == 2 {
            let getFormReportsVc = GetFormReportsViewController(nibName: "GetFormReportsViewController", bundle: nil)
            
            navigationController?.pushViewController(getFormReportsVc, animated: true)
        } else if indexPath.row == 3 {
            let createFormVc = CreateFormViewController(nibName: "CreateFormViewController", bundle: nil)
            
            navigationController?.pushViewController(createFormVc, animated: true)
        } else if indexPath.row == 4 {
            let createSubmissionVc = CreateSubmissionViewController(nibName: "CreateSubmissionViewController", bundle: nil)
            
            navigationController?.pushViewController(createSubmissionVc, animated: true)
        } else if indexPath.row == 5 {
            let createReportVc = CreateReportViewController(nibName: "CreateReportViewController", bundle: nil)
            
            navigationController?.pushViewController(createReportVc, animated: true)
        } else if indexPath.row == 6 {
            let registerUserVc = RegisterUserViewController(nibName: "RegisterUserViewController", bundle: nil)
            
            navigationController?.pushViewController(registerUserVc, animated: true)
        } else if indexPath.row == 7 {
            let createQuestionVc = CreateQuestionViewController(nibName: "CreateQuestionViewController", bundle: nil)
            
            navigationController?.pushViewController(createQuestionVc, animated: true)
        } else if indexPath.row == 8 {
            let loadSettingsVC = LoadSettingsViewController(nibName: "LoadSettingsViewController", bundle: nil)
            
            navigationController?.pushViewController(loadSettingsVC, animated: true)
        } else if indexPath.row == 9 {
            let getHistoryVC = GetHistoryViewController(nibName: "GetHistoryViewController", bundle: nil)
            
            navigationController?.pushViewController(getHistoryVC, animated: true)
        } else if indexPath.row == 10 {
            let getFormPropertiesVC = GetFormPropertiesViewController(nibName: "GetFormPropertiesViewController", bundle: nil)
            
            navigationController?.pushViewController(getFormPropertiesVC, animated: true)
        } else if indexPath.row == 11 {
            let createFormPropertiesVC = CreateFormPropertiesViewController(nibName: "CreateFormPropertiesViewController", bundle: nil)
            
            navigationController?.pushViewController(createFormPropertiesVC, animated: true)
        } else if indexPath.row == 12 {
            let createFormsVC  = CreateFormsViewController(nibName: "CreateFormsViewController", bundle: nil)
            
            navigationController?.pushViewController(createFormsVC, animated: true)
        } else if indexPath.row == 13 {
            let createFormQuestionsVC = CreateFormQuestionsViewController(nibName: "CreateFormQuestionsViewController", bundle: nil)
            
            navigationController?.pushViewController(createFormQuestionsVC, animated: true)
        }
    }
}
