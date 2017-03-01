//
//  GetFormReportsViewController.m
//  JotFormTest
//
//  Created by Administrator on 1/7/14.
//  Copyright (c) 2014 Interlogy, LLC. All rights reserved.
//

#import "GetFormReportsViewController.h"
#import "DataListViewController.h"
#import "SVProgressHUD.h"
#import "SharedData.h"
#import <JotForm_iOS/JotForm.h>
#import "Common.h"

@interface GetFormReportsViewController ()

@end

@implementation GetFormReportsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Get form reports";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User definition emthod

- (void) startDataListViewController : (NSArray *) reportList
{
    DataListViewController *dataListVc = [[DataListViewController alloc] initWithNibName:@"DataListViewController" bundle:nil];
    
    [self.navigationController pushViewController:dataListVc animated:YES];
    
    [dataListVc setReportList:reportList type:DataListTypeFormList];
}


- (IBAction) getFormReportsButtonClicked : (id) sender
{
    [SVProgressHUD showWithStatus:@"Loading reports..."];
    
    SharedData *sharedData = [SharedData sharedData];
    
    if ( FORM_ID == 0 ) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"JotFormAPISample" message:@"Please put Form's id in line 19, Common.h" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
        
        return;
    }
    
    [sharedData.apiClient getFormReports:FORM_ID onSuccess:^(id result) {
        [SVProgressHUD dismiss];
        
        if ( result != nil ) {
            
            NSInteger responseCode = [[result objectForKey:@"responseCode"] integerValue];
            
            if ( responseCode == 200 || responseCode == 206 ) {
                
                NSArray *reportsArray = [result objectForKey:@"content"];
                
                [self startDataListViewController:reportsArray];
            }   
        }
    }onFailure:^(id error) {
          [SVProgressHUD dismiss];
    }];
}

@end
