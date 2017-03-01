//
//  CreateQuestionViewController.m
//  JotFormTest
//
//  Created by Administrator on 1/8/14.
//  Copyright (c) 2014 wang. All rights reserved.
//

#import "CreateQuestionViewController.h"
#import "Common.h"
#import "SharedData.h"
#import "SVProgressHUD.h"

@interface CreateQuestionViewController ()

@end

@implementation CreateQuestionViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User definition method

- (void) createFormQuestion
{
    if (FORM_ID == 0) {
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
    }
    
    NSMutableDictionary *question = [[NSMutableDictionary alloc] init];
    
    [question setObject:@"control_textbox" forKey:@"type"];
    [question setObject:@"New Text" forKey:@"text"];
    [question setObject:@"1" forKey:@"order"];
    [question setObject:@"New Name of Question" forKey:@"1"];
    
    
    SharedData *sharedData = [SharedData sharedData];
    
    [sharedData.apiClient createFormQuestion:FORM_ID question:question onSuccess:^(id result) {
        [SVProgressHUD dismiss];
        
        if ( result != nil ) {
            NSInteger responseCode = [[result objectForKey:@"responseCode"] integerValue];
            
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
        
        if ( error != nil ) {
            NSInteger responseCode = [[error objectForKey:@"responseCode"] integerValue];
            
            if ( responseCode == 401 ) {
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

- (IBAction) createQuestionButtonClicked : (id) sender
{
    [self createFormQuestion];
}


@end
