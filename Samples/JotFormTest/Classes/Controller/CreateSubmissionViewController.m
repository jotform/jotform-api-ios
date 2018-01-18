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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User definition method

- (void)createSubmission {
    [SVProgressHUD showWithStatus:@"Creating submissions..."];
    
    NSMutableDictionary *submission = [[NSMutableDictionary alloc] init];
    [submission setObject:@"XXX" forKey:@"1"];
    [submission setObject:@"This is a test for creating submission." forKey:@"2"];
    
    [[SharedData sharedData].apiClient createFormSubmissions:FORM_ID submission:submission onSuccess:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result) {
            NSInteger responseCode = [[result objectForKey:@"responseCode"] integerValue];
            
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
