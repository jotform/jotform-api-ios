//
//  RegisterUserViewController.m
//  JotFormTest
//
//  Created by Administrator on 1/8/14.
//  Copyright (c) 2014 wang. All rights reserved.
//

#import "RegisterUserViewController.h"
#import "SharedData.h"
#import "SVProgressHUD.h"

@interface RegisterUserViewController ()

@end

@implementation RegisterUserViewController

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
    
    self.title = @"Register user";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User definition method

- (void) registerUser
{
    if ( mUsernameTextField.text.length == 0 ) {
        
        [mUsernameTextField becomeFirstResponder];
        return;
        
    }
    
    if ( mPasswordTextField.text.length == 0 ) {
        
        [mPasswordTextField becomeFirstResponder];
        return;
        
    }
    
    if ( mEmailTextField.text.length == 0 ) {
        
        [mEmailTextField becomeFirstResponder];
        return;
        
    }
    
    [SVProgressHUD showWithStatus:@"Registering user..."];
    
    SharedData *sharedData = [SharedData sharedData];
    
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setObject:mUsernameTextField.text forKey:@"username"];
    [userInfo setObject:mPasswordTextField.text forKey:@"password"];
    [userInfo setObject:mEmailTextField.text forKey:@"email"];
    
    [sharedData.apiClient setDelegate:self];
    [sharedData.apiClient setDidFinishSelector:@selector(registerUserFinish:)];
    [sharedData.apiClient setDidFailSelector:@selector(registerUserFail:)];
    
    [sharedData.apiClient registerUser:userInfo];
}

#pragma mark - IBAction

- (IBAction) registerButtonClicked : (id) sender
{
    [self registerUser];
}

#pragma mark - Jotform delegate

- (void) registerUserFinish : (id) result
{
    [SVProgressHUD dismiss];
    
    if ( result != nil ) {
        
        int responseCode = [[result objectForKey:@"responseCode"] integerValue];
        
        if ( responseCode == 200 || responseCode == 206 ) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"JotFormAPISample" message:@"You registered new user successfully." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            return;

        } else {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"JotFormAPISample" message:[result objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            
            [alertView show];
        }
    }
}

- (void) registerUserFail : (id) error
{
    [SVProgressHUD dismiss];
}

@end
