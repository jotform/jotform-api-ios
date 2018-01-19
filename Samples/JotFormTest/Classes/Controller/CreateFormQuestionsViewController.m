//
//  CreateFormsViewController.m
//  JotFormTest
//
//  Created by Curtis Stilwell on 10/20/14.
//  Copyright (c) 2014 wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CreateFormQuestionsViewController.h"
#import "Common.h"
#import "SharedData.h"
#import "SVProgressHUD.h"

@implementation CreateFormQuestionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - User definition method

- (void)createFormQuestions {
    NSString *jsonString = @"{\"questions\":{\"1\":{\"type\":\"control_head\",\"text\":\"Text 1\",\"order\":\"1\",\"name\":\"Header1\"},\"2\":{\"type\":\"control_head\",\"text\":\"Text 2\",\"order\":\"2\",\"name\":\"Header2\"}}}";

    [[SharedData sharedData].apiClient createFormQuestions:FORM_ID questions:jsonString onSuccess:^(id result) {
        [SVProgressHUD dismiss];
        
        if (result) {
            NSInteger responseCode = [[result objectForKey:@"responseCode"] integerValue];
            
            if (responseCode == 200 || responseCode == 206) {
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
        
    }];
    
}

#pragma mark - IBAction

- (IBAction)createFormQuestionsClicked:(id)sender {
    [self createFormQuestions];
}

@end
