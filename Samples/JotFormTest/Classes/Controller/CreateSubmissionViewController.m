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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Create submission";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User definition method

- (void) createSubmission
{
    [SVProgressHUD showWithStatus:@"Creating submissions..."];
    
    SharedData *sharedData = [SharedData sharedData];
    
    NSMutableDictionary *submission = [[NSMutableDictionary alloc] init];
    [submission setObject:@"XXX" forKey:@"1"];
    [submission setObject:@"This is a test for creating submission." forKey:@"2"];
    
    [sharedData.apiClient createForm:FORM_ID onSuccess:^(id result) {
        [SVProgressHUD dismiss];
        
        if ( result != nil ) {
            NSInteger responseCode = [[result objectForKey:@"responseCode"] integerValue];
            
            if ( responseCode == 200 || responseCode == 206 ) {
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"JotFormAPISample" message:@"You created submission successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                
                [alertView show];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    } onFailure:^(id error) {
        [SVProgressHUD dismiss];
        
        if (error != nil) {
           NSInteger responseCode = [[error objectForKey:@"responseCode"] integerValue];
            
            if ( responseCode == 401 ) {
                
                NSString *errMsg = [NSString stringWithFormat:@"%@\n Please check if your API Key's permission is 'Read Access' or 'Full Access'. You can create submission with API key for 'Full Access'", [error objectForKey:@"message"]];
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"JotFormAPISample" message:errMsg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                
                [alertView show];
                
                return;
            }
        }
    }];
}

#pragma mark - IBAction

- (IBAction) createSubmissionButtonClicked : (id) sender
{
    [self createSubmission];
}

@end
