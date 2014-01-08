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
    
    self.title = @"Create report";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User definition method

- (void) createReport
{
    // check if FORM_ID is specified
    
    if ( FORM_ID == 0 ) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"JotformAPISample" message:@"Please put Form's id in line 22, Common.h" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
        
        return;
    }
    
    [SVProgressHUD showWithStatus:@"Creating report..."];
    
    SharedData *sharedData = [SharedData sharedData];
    
    [sharedData.apiClient setDelegate:self];
    [sharedData.apiClient setDidFinishSelector:@selector(createReportFinish:)];
    [sharedData.apiClient setDidFailSelector:@selector(createReportFail:)];
    [sharedData.apiClient createReport:FORM_ID title:@"Test Report" list_type:@"csv" fields:@"date"];
}

#pragma mark - IBAction

- (IBAction) createReportButtonClicked : (id) sender
{
    [self createReport];
}

#pragma mark - Jotform delegate

- (void) createReportFinish : (id) result
{
    [SVProgressHUD dismiss];
    
    if ( result != nil ) {
        
        int responseCode = [[result objectForKey:@"responseCode"] integerValue];
        
        if ( responseCode == 200 || responseCode == 206 ) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"JotFormAPISample" message:@"You created report successfully." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            
            [alertView show];
            
            return;
        }
    }
}

- (void) createReportFail : (id) error
{
    [SVProgressHUD dismiss];
    
    if ( error != nil ) {
        
        int responseCode = [[error objectForKey:@"responseCode"] integerValue];
        
        if ( responseCode == 401 ) {
            
            NSString *errMsg = [NSString stringWithFormat:@"%@\nPlease check if your API Key's permission is 'Read Access' or 'Full Access'. You can create form with API key for 'Full Access'", [error objectForKey:@"message"]];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"JotFormAPISample" message:errMsg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            
            [alertView show];
            
            return;
        }
    }
}

@end
