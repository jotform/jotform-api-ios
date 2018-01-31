//
//  RegisterUserViewController.m
//  JotFormTest
//
//  Created by Administrator on 1/8/14.
//  Copyright (c) 2014 wang. All rights reserved.
//

#import "RegisterUserViewController.h"
#import "SVProgressHUD.h"

@interface RegisterUserViewController ()

@property (nonatomic,weak) IBOutlet UITextField *usernameTextField;
@property (nonatomic,weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic,weak) IBOutlet UITextField *emailTextField;

@end

@implementation RegisterUserViewController

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
    
    self.title = @"Register user";
}

#pragma mark - User definition method

- (void)registerUser {
    if (self.usernameTextField.text.length == 0) {
        [self.usernameTextField becomeFirstResponder];
        return;
    }
    
    if (self.passwordTextField.text.length == 0) {
        [self.passwordTextField becomeFirstResponder];
        return;
    }
    
    if (self.emailTextField.text.length == 0) {
        [self.emailTextField becomeFirstResponder];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"Registering user..."];
    
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    userInfo[@"username"] = self.usernameTextField.text;
    userInfo[@"password"] = self.passwordTextField.text;
    userInfo[@"email"] = self.emailTextField.text;
    
    /* [[SharedData sharedData].apiClient registerUser:userInfo onSuccess:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result) {
            NSInteger responseCode = [result[@"responseCode"] integerValue];
            
            if (responseCode == 200 || responseCode == 206) {
                UIAlertController *alertView = [UIAlertController
                                                alertControllerWithTitle:@"JotFormAPISample"
                                                message:@"You registered new user successfully."
                                                preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancelButton = [UIAlertAction
                                               actionWithTitle:@"Ok"
                                               style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction *action){
                                                   
                                               }];
                
                [alertView addAction:cancelButton];
                [self presentViewController:alertView animated:YES completion:nil];
            } else {
                UIAlertController *alertView = [UIAlertController
                                                alertControllerWithTitle:@"JotFormAPISample"
                                                message:result[@"message"]
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
    }]; */
}

#pragma mark - IBAction

- (IBAction)registerButtonClicked:(id)sender {
    [self registerUser];
}


@end
