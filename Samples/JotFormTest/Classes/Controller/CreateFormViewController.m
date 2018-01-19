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
#import <JotForm_iOS/JotForm.h>

@interface CreateFormViewController ()

@end

@implementation CreateFormViewController

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
    
    self.title = @"Create form";
}

#pragma mark - IBAction

- (IBAction)createFormButtonClicked:(id)sender {
    [SVProgressHUD showWithStatus:@"Creating form..."];
    
    // create form using JotformAPI client
    NSMutableDictionary *properties = [[NSMutableDictionary alloc] init];
    [properties setObject:@"Test Form" forKey:@"title"];
    
    NSMutableDictionary *questions = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *questionItem = [[NSMutableDictionary alloc] init];
    [questionItem setObject:@"control_textbox" forKey:@"type"];
    [questionItem setObject:@"Name" forKey:@"text"];
    [questionItem setObject:@"1" forKey:@"order"];
    [questionItem setObject:@"textboxName" forKey:@"1"];

    [questions setObject:questionItem forKey:@"1"];

    questionItem = [[NSMutableDictionary alloc] init];
    [questionItem setObject:@"control_textarea" forKey:@"type"];
    [questionItem setObject:@"Message" forKey:@"text"];
    [questionItem setObject:@"2" forKey:@"order"];
    [questionItem setObject:@"textboxMessage" forKey:@"name"];
    
    [questions setObject:questionItem forKey:@"2"];
    
    NSMutableDictionary *form = [[NSMutableDictionary alloc] init];
    [form setObject:properties forKey:@"properties"];
    [form setObject:questions forKey:@"questions"];
    
    [[SharedData sharedData].apiClient createForm:form onSuccess:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result) {
            NSInteger responseCode = [[result objectForKey:@"responseCode"] integerValue];
            
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
            NSInteger responseCode = [[error objectForKey:@"response"] integerValue];
            
            if (responseCode == 401) {
                NSString *errMsg = [NSString stringWithFormat:@"%@\n Please check if your API Key's permission is 'Read Access' or 'Full Access'. You can create form with API Key for 'Full Access'", [error objectForKey:@"message"]];
                
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
