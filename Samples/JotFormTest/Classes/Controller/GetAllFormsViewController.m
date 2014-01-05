//
//  GetAllFormsViewController.m
//  JotFormTest
//
//  Created by Administrator on 1/6/14.
//  Copyright (c) 2014 wang. All rights reserved.
//

#import "GetAllFormsViewController.h"
#import "SharedData.h"

@interface GetAllFormsViewController ()

@end

@implementation GetAllFormsViewController

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

#pragma mark - user definition method

- (void) initUI
{
    
}

- (void) initData
{
    SharedData *sharedData = [SharedData sharedData];
    
}

#pragma mark -
#pragma mark UIPickerViewDataSource

/*
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return 0;
}


#pragma mark -
#pragma mark UIPickerView delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if(0 == row) {
        return @"Create new user";
    }
    
    if([lists count]) {
        UserList *userList = [lists objectAtIndex:row - 1];
        return userList.username;
    }
    
    return nil;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}
*/

@end
