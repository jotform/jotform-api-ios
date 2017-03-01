//
//  CreateFormsViewController.m
//  JotFormTest
//
//  Created by Curtis Stilwell on 10/20/14.
//  Copyright (c) 2014 wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CreateFormsViewController.h"
#import "Common.h"
#import "SharedData.h"
#import "SVProgressHUD.h"

@interface CreateFormsViewController ()

@end

@implementation CreateFormsViewController

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

- (void) createForms
{
    SharedData *sharedData = [SharedData sharedData];
    
    NSString *jsonString = @"{\"questions\":[{\"type\":\"control_head\"}]}";

    [sharedData.apiClient createForms:jsonString onSuccess:^(id result){
        
    } onFailure:^(id response) {
        
    }];
}

#pragma mark - IBAction

- (IBAction) createFormsViewClicked : (id) sender
{
    [self createForms];
}

#pragma mark - Jotform delegate

- (void) createFormsFinish : (id) result
{
    [SVProgressHUD dismiss];
    
    if ( result != nil ) {
        NSInteger responseCode = [[result objectForKey:@"responseCode"] integerValue];
        
        if ( responseCode == 200 || responseCode == 206 ) {
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
            
            return;
            
        }
        
    }
}

- (void) createFormsFail : (id) error
{
}




@end
