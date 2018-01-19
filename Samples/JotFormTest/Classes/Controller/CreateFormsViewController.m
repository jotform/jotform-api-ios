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

@implementation CreateFormsViewController

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

- (void)createForms {
    NSError *error = nil;
    NSData *objectData = [@"{\"questions\":[{\"type\":\"control_head\"}]}" dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
  
    [[SharedData sharedData].apiClient createForms:json onSuccess:^(id result){
   
    } onFailure:^(NSError *error) {

    }];
}

#pragma mark - IBAction

- (IBAction)createFormsViewClicked:(id)sender {
    [self createForms];
}


@end
