//
//  CreateSubmissionViewController.m
//  JotFormTest
//
//  Created by Interlogy, LLC on 1/7/14.
//  Copyright (c) 2014 Interlogy, LLC. All rights reserved.
//

#import "CreateSubmissionViewController.h"
#import "SVProgressHUD.h"
#import "SharedData.h"
#import "Common.h"
#import <JotForm_iOS/JotForm.h>

@interface CreateSubmissionViewController ()

@end

@implementation CreateSubmissionViewController

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
    
    self.title = @"Create submission";
}


#pragma mark - User definition method

- (void)createSubmission {
    [SVProgressHUD showWithStatus:@"Creating submissions..."];
    
    NSMutableDictionary *submission = [[NSMutableDictionary alloc] init];
    submission[@"1"] = @"XXX";
    submission[@"2"] = @"This is a test for creating submission.";
    
    [[SharedData sharedData].apiClient createFormSubmissions:FORM_ID submission:submission onSuccess:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result) {
            NSInteger responseCode = [result[@"responseCode"] integerValue];
            
            if (responseCode == 200 || responseCode == 206) {
                UIAlertController *alertView = [UIAlertController
                                                alertControllerWithTitle:@"JotFormAPISample"
                                                message:@"You created submission successfully"
                                                preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancelButton = [UIAlertAction
                                               actionWithTitle:@"Ok"
                                               style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction *action){
                                                   
                                               }];
                
                [alertView addAction:cancelButton];
                [self presentViewController:alertView animated:YES completion:nil];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
      } onFailure:^(id error) {
   
      }];
}

#pragma mark - IBAction

- (IBAction)createSubmissionButtonClicked:(id)sender {
    [self createSubmission];
}

@end
