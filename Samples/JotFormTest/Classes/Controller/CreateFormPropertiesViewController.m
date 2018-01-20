//
//  CreateFormProperties.m
//  JotFormTest
//
//  Created by Curtis Stilwell on 8/21/17.
//  Copyright © 2017 wang. All rights reserved.
//

#import "CreateFormPropertiesViewController.h"
#import "Common.h"
#import "SharedData.h"

@interface CreateFormPropertiesViewController ()

@end

@implementation CreateFormPropertiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - IBAction

- (IBAction)createFormPropertiesClicked:(id)sender {
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    userInfo[@"350"] = @"properties[formWidth]";
    
    [[SharedData sharedData].apiClient setFormProperties:FORM_ID formProperties:userInfo onSuccess:^(id result) {
     
    } onFailure:^(NSError *error) {
        
    }];
}

@end
