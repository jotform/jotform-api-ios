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
#import <JotForm_iOS/JotForm_iOS-Swift.h>
#import "Common.h"

@interface GetFormReportsViewController ()

@end

@implementation GetFormReportsViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Get form reports";
}

#pragma mark - User definition emthod

- (void) startDataListViewController:(NSArray *)reportList {
    DataListViewController *dataListVc = [[DataListViewController alloc] initWithNibName:@"DataListViewController" bundle:nil];
    
    [dataListVc setList:reportList type:DataListTypeFormList];
    
    [self.navigationController pushViewController:dataListVc animated:YES];
}


- (IBAction)getFormReportsButtonClicked:(id)sender {
    if (FORM_ID == 0) {
        UIAlertController *alertView = [UIAlertController
                                        alertControllerWithTitle:@"JotFormAPISample"
                                        message:@"Please put Form's id in line 19, Common.h"
                                        preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelButton = [UIAlertAction
                                       actionWithTitle:@"Ok"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action){
                                           
                                       }];
        
        [alertView addAction:cancelButton];
        [self presentViewController:alertView animated:YES completion:nil];
    } else {
    [SVProgressHUD showWithStatus:@"Loading reports..."];
        
    [[SharedData sharedData].apiClient getFormReports:FORM_ID onSuccess:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result) {
            NSInteger responseCode = [result[@"responseCode"] integerValue];
            
            if (responseCode == 200 || responseCode == 206) {
                NSArray *reportsArray = result[@"content"];
                [self startDataListViewController:reportsArray];
            }   
        }
    } onFailure:^(id error) {
          [SVProgressHUD dismiss];
     }];
   }
}

@end
