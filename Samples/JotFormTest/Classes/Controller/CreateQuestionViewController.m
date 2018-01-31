//
//  CreateQuestionViewController.m
//  JotFormTest
//
//  Created by Administrator on 1/8/14.
//  Copyright (c) 2014 wang. All rights reserved.
//

#import "CreateQuestionViewController.h"
#import "SVProgressHUD.h"

@implementation CreateQuestionViewController

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
}

#pragma mark - User definition method

- (void)createFormQuestion {
  /*  if (FORM_ID == 0) {
        UIAlertController *alertView = [UIAlertController
                                        alertControllerWithTitle:@"JotFormAPISample"
                                        message:@"Please put Form's id in line 23"
                                        preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelButton = [UIAlertAction
                                       actionWithTitle:@"Ok"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action){
                                           
                                       }];
        
        [alertView addAction:cancelButton];
        [self presentViewController:alertView animated:YES completion:nil];

        return;
    } */
    
    NSMutableDictionary *question = [[NSMutableDictionary alloc] init];
    
    question[@"type"] = @"control_textbox";
    question[@"text"] = @"New Text";
    question[@"order"] = @"1";
    question[@"1"] = @"New Name of Question";
    
   /* [[SharedData sharedData].apiClient createFormQuestion:FORM_ID question:question onSuccess:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result) {
            NSInteger responseCode = [result[@"responseCode"] integerValue];
            
            if (responseCode == 200 || responseCode == 206 ) {
                UIAlertController *alertView = [UIAlertController
                                                alertControllerWithTitle:@"JotFormAPISample"
                                                message:@"You created question successfully."
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
    } onFailure:^(id error) {
        [SVProgressHUD dismiss];
        
        if (error) {
            NSInteger responseCode = [error[@"responseCode"] integerValue];
            
            if (responseCode == 401) {
                NSString *errMsg = [NSString stringWithFormat:@"%@\nPlease check if your API Key's permission is 'Read Access' or 'Full Access'. You can create form with API key for 'Full Access'", error[@"message"]];
               
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
    }]; */
}

#pragma mark - IBAction

- (IBAction) createQuestionButtonClicked:(id)sender {
    [self createFormQuestion];
}


@end
