//
//  SampleListViewController.m
//  JotFormTest
//
//  Created by Interlogy, LLC on 1/5/14.
//  Copyright (c) 2014 Interlogy, LLC. All rights reserved.
//

#import "SampleListViewController.h"
#import "GetFormReportsViewController.h"
#import "GetAllFormsViewController.h"
#import "GetAllSubmissionsViewController.h"
#import "CreateFormViewController.h"
#import "CreateSubmissionViewController.h"
#import "CreateReportViewController.h"
#import "RegisterUserViewController.h"
#import "CreateFormsViewController.h"
#import "CreateFormQuestionsViewController.h"
#import "CreateQuestionViewController.h"
#import "LoadSettingsViewController.h"
#import "GetHistoryViewController.h"
#import "GetFormPropertiesViewController.h"
#import "CreateFormPropertiesViewController.h"
#import "SharedData.h"


@interface SampleListViewController ()

@end

@implementation SampleListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"API sample list";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[SharedData sharedData].sampleStrList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SampleCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SampleCell"];
    }
    
    NSString *sampleStr = [[SharedData sharedData].sampleStrList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = sampleStr;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;

    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        GetAllFormsViewController *getAllFormsVc = [[GetAllFormsViewController alloc] initWithNibName:@"GetAllFormsViewController" bundle:nil];
        
        [self.navigationController pushViewController:getAllFormsVc animated:YES];
    } else if (indexPath.row == 1) {
        GetAllSubmissionsViewController *getAllSubmissionsVc = [[GetAllSubmissionsViewController alloc] initWithNibName:@"GetAllSubmissionsViewController" bundle:nil];
        
        [self.navigationController pushViewController:getAllSubmissionsVc animated:YES];
    } else if (indexPath.row == 2) {
        GetFormReportsViewController *formReportVc = [[GetFormReportsViewController alloc] initWithNibName:@"GetFormReportsViewController" bundle:nil];
        
        [self.navigationController pushViewController:formReportVc animated:YES];
    } else if (indexPath.row == 3) {
        CreateFormViewController *createFormVc = [[CreateFormViewController alloc] initWithNibName:@"CreateFormViewController" bundle:nil];

        [self.navigationController pushViewController:createFormVc animated:YES];
    } else if (indexPath.row == 4) {
        CreateSubmissionViewController *createSubmissionVc = [[CreateSubmissionViewController alloc] initWithNibName:@"CreateSubmissionViewController" bundle:nil];
        
        [self.navigationController pushViewController:createSubmissionVc animated:YES];
    } else if (indexPath.row == 5) {
        CreateReportViewController *createReportVc = [[CreateReportViewController alloc] initWithNibName:@"CreateReportViewController" bundle:nil];
        
        [self.navigationController pushViewController:createReportVc animated:YES];
    } else if (indexPath.row == 6) {
        RegisterUserViewController *registerUserVc = [[RegisterUserViewController alloc] initWithNibName:@"RegisterUserViewController" bundle:nil];
        
        [self.navigationController pushViewController:registerUserVc animated:YES];
    } else if (indexPath.row == 7) {
       CreateQuestionViewController *createQuestionVc = [[CreateQuestionViewController alloc] initWithNibName:@"CreateQuestionViewController" bundle:nil];
        
        [self.navigationController pushViewController:createQuestionVc animated:YES];
    } else if (indexPath.row == 8) {
        LoadSettingsViewController *loadSettingsVC = [[LoadSettingsViewController alloc] initWithNibName:@"LoadSettingsViewController" bundle:nil];
        
        [self.navigationController pushViewController:loadSettingsVC animated:YES];
    } else if (indexPath.row == 9) {
        GetHistoryViewController *getHistoryVC = [[GetHistoryViewController alloc] initWithNibName:@"GetHistoryViewController" bundle:nil];
        
        [self.navigationController pushViewController:getHistoryVC animated:YES];
    } else if (indexPath.row == 10) {
        GetFormPropertiesViewController *getFormPropertiesVC = [[GetFormPropertiesViewController alloc] initWithNibName:@"GetFormPropertiesViewController" bundle:nil];
        
        [self.navigationController pushViewController:getFormPropertiesVC animated:YES];
    } else if (indexPath.row == 11) {
        CreateFormPropertiesViewController *createFormPropertiesVC = [[CreateFormPropertiesViewController alloc]initWithNibName:@"CreateFormPropertiesViewController" bundle:nil];
        
        [self.navigationController pushViewController:createFormPropertiesVC animated:YES];
    } else if (indexPath.row == 12) {
        CreateFormsViewController *createFormsVC = [[CreateFormsViewController alloc]initWithNibName:@"CreateFormsViewController" bundle:nil];
        
        [self.navigationController pushViewController:createFormsVC animated:YES];
    } else if (indexPath.row == 13) {
        CreateFormQuestionsViewController *createFormQuestionsVC = [[CreateFormQuestionsViewController alloc] initWithNibName:@"CreateFormQuestionsViewController" bundle:nil];
        
        [self.navigationController pushViewController:createFormQuestionsVC animated:YES];
    }
}

@end
