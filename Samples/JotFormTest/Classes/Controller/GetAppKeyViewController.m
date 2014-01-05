//
//  GetAppKeyViewController.m
//  JotFormTest
//
//  Created by Administrator on 1/5/14.
//  Copyright (c) 2014 Interlogy, LLC. All rights reserved.
//

#import "GetAppKeyViewController.h"
#import "SharedData.h"
#import "SVProgressHUD.h"

@interface GetAppKeyViewController ()

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - user definition method

- (void) initUI
{
    
}

- (void) initData
{
    apiClient = [[JotForm alloc] init];
    apiClient.delegate = self;
}

#pragma mark - IBAction

- (IBAction) getAppKeyButtonClicked : (id) sender
{
    NSString *username = mUsernameTextField.text;
    
    if ( [username isEqualToString:@""] )
        [mUsernameTextField becomeFirstResponder];
    
    NSString *password = mPasswordTextField.text;
    
    if ( [password isEqualToString:@""] )
        [mPasswordTextField becomeFirstResponder];
    
    [mUsernameTextField resignFirstResponder];
    [mPasswordTextField resignFirstResponder];
    
    [SVProgressHUD showWithStatus:@"Getting app key..."];
    
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setObject:username forKey:@"username"];
    [userInfo setObject:password forKey:@"password"];
    [userInfo setObject:@"JotformAPISample" forKey:@"appName"];
    [userInfo setObject:@"full" forKey:@"access"];
    
    [apiClient setDidFinishSelector:@selector(loginFinish:)];
    [apiClient setDidFailSelector:@selector(loginFail:)];
    [apiClient login:userInfo];
}

#pragma mark - Jotform delegate

- (void) loginFinish : (id) result
{
    [SVProgressHUD dismiss];
}

- (void) loginFail : (id) error
{
    [SVProgressHUD dismiss];
}

@end
