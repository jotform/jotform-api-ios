//
//  GetAllFormsViewController.m
//  JotFormTest
//
//  Created by Interlogy, LLC on 1/6/14.
//  Copyright (c) 2014 Interlogy, LLC. All rights reserved.
//

#import "GetAllFormsViewController.h"
#import "DataListViewController.h"
#import "SharedData.h"
#import "SVProgressHUD.h"
#import <JotForm_iOS/JotForm.h>

@interface GetAllFormsViewController () {
           NSArray *orderbyList;
           SharedData *sharedData;
}

@property (nonatomic,weak) IBOutlet UITextField *offsetTextField;
@property (nonatomic,weak) IBOutlet UITextField *limitTextField;
@property (nonatomic,weak) IBOutlet UIPickerView *pickerView;
@property (nonatomic,weak) IBOutlet UITextField *filterTextField;
@property (nonatomic,weak) IBOutlet UIBarButtonItem *getBarButtonItem;

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
    
    [self initData];
    [self initUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - user definition method

- (void)initUI
{
    self.title = @"Get all forms";
    self.navigationItem.rightBarButtonItem = self.getBarButtonItem;
}

- (void)initData
{
    orderbyList = [[SharedData sharedData] getFormOrderbyList];
}

- (void)loadForms
{
    [SVProgressHUD showWithStatus:@"Loading forms..."];
    
    NSInteger offset = 0;
    NSInteger limit = 0;
    
    if (self.offsetTextField.text.length > 0) {
        offset = [self.offsetTextField.text integerValue];
    }
    
    if (self.limitTextField.text.length > 0) {
        limit = [self.limitTextField.text integerValue];
    }
    
    NSString *orderby = [orderbyList objectAtIndex:[self.pickerView selectedRowInComponent:0]];
    
    [[SharedData sharedData].apiClient getForms:offset limit:limit orderBy:orderby filter:nil onSuccess:^(id result){
       
        [SVProgressHUD dismiss];
        
        if (result) {
            NSInteger responseCode = [[result objectForKey:@"responseCode"] integerValue];
            
            if (responseCode == 200 || responseCode == 206) {
                NSArray *formsArray = [result objectForKey:@"content"];
                [self startDataListViewController:formsArray];
            }
        }
  
    } onFailure:^(id error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)startDataListViewController : (NSArray *) datalist
{
    DataListViewController *dataListVc = [[DataListViewController alloc] initWithNibName:@"DataListViewController" bundle:nil];

    [self.navigationController pushViewController:dataListVc animated:YES];
    
    [dataListVc setList:datalist type:DataListTypeFormList];
}

#pragma mark IBAction

- (IBAction)getFormsButtonClicked : (id) sender {
       [self loadForms];
}

#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [orderbyList count];
}

#pragma mark UIPickerView delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *rowStr = [orderbyList objectAtIndex:row];
    
    return rowStr;
}

@end
