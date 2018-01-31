//
//  GetAppKeyViewController.m
//  JotFormTest
//
//  Created by Interlogy, LLC on 1/5/14.
//  Copyright (c) 2014 Interlogy, LLC. All rights reserved.
//

#import "GetAppKeyViewController.h"
#import "SampleListViewController.h"
#import "SVProgressHUD.h"
#import <JotForm_iOS/JotForm_iOS-Swift.h>

@interface GetAppKeyViewController () {
    JotForm *apiClient;
}

@property (nonatomic,weak) IBOutlet UITextField *usernameTextField;
@property (nonatomic,weak) IBOutlet UITextField *passwordTextField;

@end

@implementation GetAppKeyViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    apiClient = [[JotForm alloc]initWithApiKey:@"" debugMode:NO euApi:NO];
    self.title = @"Get App Key";
    
    [self showAlertView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:NO];
    self.usernameTextField.text = @"";
    self.passwordTextField.text = @"";
}

#pragma mark - user definition method

- (void)showSampleListViewController {
    SampleListViewController *sampleListVc = [[SampleListViewController alloc] initWithNibName:@"SampleListViewController" bundle:nil];
    
    [self.navigationController pushViewController:sampleListVc animated:YES];
}

- (void)showAlertView {
   /* UIAlertController *alertView = [UIAlertController
                                    alertControllerWithTitle:@"JotFormAPISample"
                                    message:@"Do you have an API key?"
                                    preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesButton = [UIAlertAction actionWithTitle:@"Yes"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
                                                         if ([API_KEY isEqualToString:@""]) {
                                                             
                                                             UIAlertController *alertViewCancel = [UIAlertController
                                                                                                   alertControllerWithTitle:@"JotFormAPISample"
                                                                                                   message:@"Please put your API key in Common.h." preferredStyle:UIAlertControllerStyleAlert];
                                                             
                                                             UIAlertAction *cancelButton = [UIAlertAction
                                                                                            actionWithTitle:@"Ok"
                                                                                            style:UIAlertActionStyleDefault
                                                                                            handler:^(UIAlertAction *action){
                                                                                            }];
                                                             [alertViewCancel addAction:cancelButton];
                                                             [self presentViewController:alertViewCancel animated:YES completion:nil];
                                                         } else {
                                                             [[SharedData sharedData] initAPIClient:API_KEY euApi:EU_API];
                                                             
                                                             [self showSampleListViewController];
                                                         }
                                                         
                                                     }];
    
    UIAlertAction *noButton = [UIAlertAction
                                actionWithTitle:@"No"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action){
                                    
                                }];
    
    [alertView addAction:yesButton];
    [alertView addAction:noButton];
    [self presentViewController:alertView animated:YES completion:nil]; */
}

#pragma mark - IBAction

- (IBAction)getAppKeyButtonClicked:(id)sender {
    // Remove cookies to avoid EU API issue.
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in storage.cookies) {
        [storage deleteCookie:cookie];
    }
    
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
    [SVProgressHUD showWithStatus:@"Getting app key..."];
    
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    userInfo[@"username"] = self.usernameTextField.text;
    userInfo[@"password"] = self.passwordTextField.text;
    userInfo[@"appName"] = @"JotFormAPISample";
    userInfo[@"access"] = @"full";
    
    [apiClient login:userInfo onSuccess:^(id result) {
        if (result) {
            NSInteger responseCode = [result[@"responseCode"] integerValue];
            
            if (responseCode == 200 || responseCode == 206 ) {
                NSString *appKey = result[@"content"][@"appKey"];
                [self checkEuServer:appKey];
            }
        }
    } onFailure:^(id error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)checkEuServer:(NSString *)appKey {
    [apiClient checkEUserver:appKey onSuccess:^(id result) {
        BOOL isEuServer = [result[@"content"][@"euOnly"]boolValue];
        
      //  [[SharedData sharedData] initAPIClient:appKey euApi:isEuServer];
        
        [self showSampleListViewController];
        [SVProgressHUD dismiss];
    } onFailure:^(NSError *error) {
         [SVProgressHUD dismiss];
    }];
}


@end
