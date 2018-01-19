//
//  CreateReportViewController.m
//  JotFormTest
//
//  Created by Interlogy, LLC on 1/8/14.
//  Copyright (c) 2014 Interlogy, LLC. All rights reserved.
//

#import "CreateReportViewController.h"
#import "SVProgressHUD.h"
#import "Common.h"
#import "SharedData.h"

@interface CreateReportViewController ()

@end

@implementation CreateReportViewController

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
    
    self.title = @"Create report";
}

#pragma mark - User definition method

- (void)createReport {
    // check if FORM_ID is specified
    if (FORM_ID == 0) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"JotFormAPISample" message:@"Please put Form's id in line 22, Common.h" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelButton = [UIAlertAction
                                       actionWithTitle:@"Ok"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action){
                                           
                                       }];
        
        [alertView addAction:cancelButton];
        [self presentViewController:alertView animated:YES completion:nil];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"Creating report..."];
    
    [[SharedData sharedData].apiClient createReport:FORM_ID title:@"Test Report" list_type:@"csv" fields:@"date" onSuccess:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result) {
            NSInteger responseCode = [[result objectForKey:@"responseCode"] integerValue];
            
            if (responseCode == 200 || responseCode == 206) {
                UIAlertController *alertView = [UIAlertController
                                                alertControllerWithTitle:@"JotFormAPISample"
                                                message:@"You created report successfully."
                                                preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancelButton = [UIAlertAction
                                               actionWithTitle:@"Ok"
                                               style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction *action){
                                                   
                                               }];
                
                [alertView addAction:cancelButton];
                [self presentViewController:alertView animated:YES completion:nil];
            }
        }
    } onFailure:^(id error){
        [SVProgressHUD dismiss];
        
        if (error) {
            NSInteger responseCode = [[error objectForKey:@"responseCode"] integerValue];
            
            if (responseCode == 401) {
                 NSString *errMsg = [NSString stringWithFormat:@"%@\nPlease check if your API Key's permission is 'Read Access' or 'Full Access'. You can create form with API key for 'Full Access'", [error objectForKey:@"message"]];
                
                UIAlertController *alertView = [UIAlertController
                                                alertControllerWithTitle:@"JotFormAPISample"
                                                message:errMsg
                                                preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancelButton = [UIAlertAction
                                               actionWithTitle:@"Ok"
                                               style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction *action){
                                                   
                                               }];
                
                [alertView addAction:cancelButton];
                [self presentViewController:alertView animated:YES completion:nil];
            }
        }

    }];
}

#pragma mark - IBAction

- (IBAction)createReportButtonClicked:(id)sender {
    [self createReport];
}


@end
