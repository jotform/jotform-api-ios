//
//  GetAppKeyViewController.m
//  JotFormTest
//
//  Created by Interlogy, LLC on 1/5/14.
//  Copyright (c) 2014 Interlogy, LLC. All rights reserved.
//

#import "GetAppKeyViewController.h"
#import "SampleListViewController.h"
#import "SharedData.h"
#import "SVProgressHUD.h"
#import <JotForm_iOS/JotForm.h>
#import "Common.h"

@interface GetAppKeyViewController () {
    JotForm *apiClient;
    IBOutlet UITextField *usernameTextField;
    IBOutlet UITextField *passwordTextField;
}

@end

@implementation GetAppKeyViewController

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
    
    self.title = @"Get App Key";
    
    [self initData];
    
    [self showAlertView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - user definition method

- (void) initData
{
    apiClient = [[JotForm alloc] init];
}

- (void) showSampleListViewController
{
    SampleListViewController *sampleListVc = [[SampleListViewController alloc] initWithNibName:@"SampleListViewController" bundle:nil];
    
    [self.navigationController pushViewController:sampleListVc animated:YES];
}

- (void) showAlertView
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"JotFormAPISample" message:@"Do you have your Jotform account?" delegate:self cancelButtonTitle:@"Yes, i have" otherButtonTitles:@"No, i have an API key", nil];
    alertView.tag = 1000;
    [alertView setDelegate:self];
    [alertView show];
}

#pragma mark - IBAction

- (IBAction) getAppKeyButtonClicked : (id) sender
{
    NSString *username = usernameTextField.text;
    
    if ( [username isEqualToString:@""] )
        [usernameTextField becomeFirstResponder];
    
    NSString *password = passwordTextField.text;
    
    if ( [password isEqualToString:@""] )
        [passwordTextField becomeFirstResponder];
    
    [usernameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    
    [SVProgressHUD showWithStatus:@"Getting app key..."];
    
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setObject:username forKey:@"username"];
    [userInfo setObject:password forKey:@"password"];
    [userInfo setObject:@"JotFormAPISample" forKey:@"appName"];
    [userInfo setObject:@"full" forKey:@"access"];

    [apiClient login:userInfo onSuccess:^(id result) {
        if ( result != nil ) {
            
            int responseCode = [[result objectForKey:@"responseCode"] integerValue];
            
            if ( responseCode == 200 || responseCode == 206 ) {
                
                id content = [result objectForKey:@"content"];
                
                SharedData *sharedData = [SharedData sharedData];
                [sharedData initAPIClient:[content objectForKey:@"appKey"]];
                
                [self showSampleListViewController];
            }
        }
        
        [SVProgressHUD dismiss];
    } onFailure:^(id error) {
          [SVProgressHUD dismiss];
    }];
}

#pragma mark - Jotform delegate

- (void) loginFinish : (id) result
{
    if ( result != nil ) {
        
        int responseCode = [[result objectForKey:@"responseCode"] integerValue];
        
        if ( responseCode == 200 || responseCode == 206 ) {
            
            id content = [result objectForKey:@"content"];
            
            SharedData *sharedData = [SharedData sharedData];
            [sharedData initAPIClient:[content objectForKey:@"appKey"]];
            
            [self showSampleListViewController];
        }
    }
    
    [SVProgressHUD dismiss];
}

- (void) loginFail : (id) error
{
    [SVProgressHUD dismiss];
}

#pragma mark - UIAlertView delegate method

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if ( buttonIndex == 0 ) {
        
        if ( alertView.tag == 1000 ) {
            
        } else if ( alertView.tag == 3000 ) {
            
            exit(0);
        }
        
    } else if ( buttonIndex == 1 ) {
        
        if ( [API_KEY isEqualToString:@""] ) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"JotFormAPISample" message:@"Please put your API key in Common.h 12 line." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            alertView.tag = 3000;
            [alertView show];
            
            return;
        }
        
        SharedData *sharedData = [SharedData sharedData];
        [sharedData initAPIClient:API_KEY];
        
        [self showSampleListViewController];
    }
}

@end
