//
//  CreateFormViewController.m
//  JotFormTest
//
//  Created by Interlogy, LLC on 1/7/14.
//  Copyright (c) 2014 Interlogy, LLC. All rights reserved.
//

#import "CreateFormViewController.h"
#import "SharedData.h"
#import "SVProgressHUD.h"
#import <JotForm_iOS/JotForm_iOS-Swift.h>

@interface CreateFormViewController ()

@end

@implementation CreateFormViewController

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
    
    self.title = @"Create form";
}

#pragma mark - IBAction

- (IBAction)createFormButtonClicked:(id)sender {
    [SVProgressHUD showWithStatus:@"Creating form..."];
    
    // create form using JotformAPI client
    NSMutableDictionary *properties = [[NSMutableDictionary alloc] init];
    properties[@"title"] = @"Test Form";
    
    NSMutableDictionary *questions = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *questionItem = [[NSMutableDictionary alloc] init];
    questionItem[@"type"] = @"control_textbox";
    questionItem[@"text"] = @"Name";
    questionItem[@"order"] = @"1";
    questionItem[@"1"] = @"textboxName";

    questions[@"1"] = questionItem;

    questionItem = [[NSMutableDictionary alloc] init];
    questionItem[@"type"] = @"control_textarea";
    questionItem[@"text"] = @"Message";
    questionItem[@"order"] = @"2";
    questionItem[@"name"] = @"textboxMessage";
    
    questions[@"2"] = questionItem;
    
    NSMutableDictionary *form = [[NSMutableDictionary alloc] init];
    form[@"properties"] = properties;
    form[@"questions"] = questions;
    
    [[SharedData sharedData].apiClient createForm:form onSuccess:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result) {
            NSInteger responseCode = [result[@"responseCode"] integerValue];
            
            if (responseCode == 200 || responseCode == 206) {
                UIAlertController *alertView = [UIAlertController
                                             alertControllerWithTitle:@"JotFormAPISample"
                                             message:@"You created form successfully"
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancelButton = [UIAlertAction
                                            actionWithTitle:@"Cancel"
                                            style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction *action){
                                                      
                                            }];
                
                [alertView addAction:cancelButton];
                [self presentViewController:alertView animated:YES completion:nil];
            }
        }
    } onFailure:^(id error) {
        [SVProgressHUD dismiss];
        
        if (error) {
            NSInteger responseCode = [error[@"response"] integerValue];
            
            if (responseCode == 401) {
                NSString *errMsg = [NSString stringWithFormat:@"%@\n Please check if your API Key's permission is 'Read Access' or 'Full Access'. You can create form with API Key for 'Full Access'", error[@"message"]];
                
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

@end
