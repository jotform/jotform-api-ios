//
//  GetAllSubmissionsViewController.m
//  JotFormTest
//
//  Created by Interlogy, LLC on 1/6/14.
//  Copyright (c) 2014 Interlogy, LLC. All rights reserved.
//

#import "GetAllSubmissionsViewController.h"
#import "SVProgressHUD.h"
#import <JotForm_iOS/JotForm_iOS-Swift.h>

@interface GetAllSubmissionsViewController () {
           NSArray *orderbyList;
}

@property (nonatomic,weak) IBOutlet UITextField *offsetTextField;
@property (nonatomic,weak) IBOutlet UITextField *limitTextField;
@property (nonatomic,weak) IBOutlet UIPickerView *pickerView;
@property (nonatomic,weak) IBOutlet UITextField  *filterTextField;
@property (nonatomic,weak) IBOutlet UIBarButtonItem *getBarButtonItem;

@end

@implementation GetAllSubmissionsViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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

#pragma mark - user definition method

- (void) initUI {
    self.title = @"Get all submissions";
    
    self.navigationItem.rightBarButtonItem = self.getBarButtonItem;
}

- (void)initData {
  //  orderbyList = [[SharedData sharedData] getFormOrderbyList];
}

- (void)loadForms {
   // [SVProgressHUD showWithStatus:@"Loading submissions..."];
    
    NSInteger offset = 0;
    NSInteger limit = 0;
    
    if (self.offsetTextField.text.length > 0) {
        offset = (self.offsetTextField.text).integerValue;
    }
    
    if (self.limitTextField.text.length > 0) {
        limit = (self.limitTextField.text).integerValue;
    }
    
   NSString *orderby = orderbyList[[self.pickerView selectedRowInComponent:0]];
    
   NSDictionary *filter = [[NSDictionary alloc]init];
    
 /*  [[SharedData sharedData].apiClient getSubmissions:offset limit:limit orderBy:orderby filter:filter onSuccess:^(id result) {
       
       [SVProgressHUD dismiss];
       
       if (result) {
           NSInteger responseCode = [result[@"responseCode"] integerValue];
           
           if (responseCode == 200 || responseCode == 206) {
               NSArray *formsArray = result[@"content"];
               [self startDataListViewController:formsArray];
           }
       }
    } onFailure:^(id response) {
        [SVProgressHUD dismiss];
    }];*/
}

- (void)startDataListViewController:(NSArray *)datalist {
   /* DataListViewController *dataListVc = [[DataListViewController alloc] initWithNibName:@"DataListViewController" bundle:nil];
    
     //[dataListVc setList:datalist type:DataListTypeSubmissionList];
    
    [self.navigationController pushViewController:dataListVc animated:YES]; */
}

#pragma mark IBAction

- (IBAction)getSubmissionsButtonClicked:(id)sender {
    [self loadForms];
}

#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return orderbyList.count;
}

#pragma mark UIPickerView delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *rowStr = orderbyList[row];
    
    return rowStr;
}

@end
