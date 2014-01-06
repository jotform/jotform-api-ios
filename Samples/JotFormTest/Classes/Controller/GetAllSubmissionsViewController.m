//
//  GetAllSubmissionsViewController.m
//  JotFormTest
//
//  Created by Administrator on 1/6/14.
//  Copyright (c) 2014 wang. All rights reserved.
//

#import "GetAllSubmissionsViewController.h"
#import "DataListViewController.h"
#import "SharedData.h"
#import "SVProgressHUD.h"

@interface GetAllSubmissionsViewController ()

@end

@implementation GetAllSubmissionsViewController

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
    
    [self initData];
    [self initUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - user definition method

- (void) initUI
{
    self.title = @"Get all submissions";
    
    self.navigationItem.rightBarButtonItem = getBarButtonItem;
}

- (void) initData
{
    SharedData *sharedData = [SharedData sharedData];
    
    orderbyList = [sharedData getFormOrderbyList];
}

- (void) loadForms
{
    [SVProgressHUD showWithStatus:@"Loading submissions..."];
    
    SharedData *sharedData = [SharedData sharedData];
    
    int offset = 0;
    
    if ( offsetTextField.text.length > 0 )
        offset = [offsetTextField.text integerValue];
    
    int limit = 0;
    
    if ( limitTextField.text.length > 0 )
        limit = [limitTextField.text integerValue];
    
    NSString *orderby = @"";
    
    orderby = [orderbyList objectAtIndex:[pickerView selectedRowInComponent:0]];
    
    [sharedData.apiClient setDelegate:self];
    [sharedData.apiClient setDidFinishSelector:@selector(loadSubmissionsFinish:)];
    [sharedData.apiClient setDidFailSelector:@selector(loadSubmissionsFail:)];
    
    [sharedData.apiClient getSubmissions:offset limit:limit orderBy:orderby filter:nil];
}

- (void) startDataListViewController : (NSArray *) datalist
{
    DataListViewController *dataListVc = [[DataListViewController alloc] initWithNibName:@"DataListViewController" bundle:nil];
    
    [self.navigationController pushViewController:dataListVc animated:YES];
    
    [dataListVc setSubmissionList:datalist type:DataListTypeSubmissionList];
}

#pragma mark -
#pragma mark IBAction

- (IBAction) getSubmissionsButtonClicked : (id) sender {
    
    [self loadForms];
}

#pragma mark -
#pragma mark UIPickerViewDataSource


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [orderbyList count];
}


#pragma mark -
#pragma mark UIPickerView delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *rowStr = [orderbyList objectAtIndex:row];
    
    return rowStr;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

#pragma mark -
#pragma mark Jotform delegate

- (void) loadSubmissionsFinish : (id) result
{
    [SVProgressHUD dismiss];
    
    if ( result != nil ) {
        
        int responseCode = [[result objectForKey:@"responseCode"] integerValue];
        
        if ( responseCode == 200 || responseCode == 206 ) {
            
            NSArray *formsArray = [result objectForKey:@"content"];
            
            [self startDataListViewController:formsArray];
        }
    }
    
}

- (void) loadFormsFail : (id) error
{
    [SVProgressHUD dismiss];
}

@end
