//
//  CreateSubmissionViewController.m
//  JotFormTest
//
//  Created by Administrator on 1/7/14.
//  Copyright (c) 2014 wang. All rights reserved.
//

#import "CreateSubmissionViewController.h"
#include "SVProgressHUD.h"
#import "SharedData.h"
#import "Common.h"

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

    [sharedData.apiClient setDelegate:self];
    [sharedData.apiClient setDidFinishSelector:@selector(createFormSubmissionFinish:)];
    [sharedData.apiClient setDidFailSelector:@selector(createFormSubmissionFail:)];
    
    [sharedData.apiClient createFormSubmissions:FORM_ID submission:submission];
}

#pragma mark - IBAction

- (IBAction) createSubmissionButtonClicked : (id) sender
{
    
}

#pragma mark - Jotform delegate

- (void) createSubmissionFinish : (id) result
{
    [SVProgressHUD dismiss];
    
    if ( result != nil ) {
        
        int responseCode = [[result objectForKey:@"responseCode"] integerValue];
        
        if ( responseCode == 200 || responseCode == 206 ) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"JotformAPISample" message:@"You created submission successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            
            [alertView show];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
}

- (void) createSubmissionFail : (id) error
{
    [SVProgressHUD dismiss];

    if ( error != nil ) {
        
        int responseCode = [[error objectForKey:@"responseCode"] integerValue];
        
        if ( responseCode == 401 ) {
            
            NSString *errMsg = [NSString stringWithFormat:@"%@\n Please check if your API Key's permission is 'Read Access' or 'Full Access'. You can create submission with API key for 'Full Access'", [error objectForKey:@"message"]];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"JotformAPISample" message:errMsg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            
            [alertView show];
            
            return;
        }
    }
}

@end
