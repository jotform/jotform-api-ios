//
//  CreateFormViewController.m
//  JotFormTest
//
//  Created by Administrator on 1/7/14.
//  Copyright (c) 2014 wang. All rights reserved.
//

#import "CreateFormViewController.h"
#import "SharedData.h"
#import "SVProgressHUD.h"

@interface CreateFormViewController ()

@end

@implementation CreateFormViewController

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
    
    self.title = @"Create form";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - user definition method

- (void) initData
{
    
}

- (void) initUI
{
    
}

#pragma mark - IBAction

- (IBAction) createFormButtonClicked : (id) sender
{
    [SVProgressHUD showWithStatus:@"Creating form..."];
    
    // create form using JotformAPI client
    SharedData *sharedData = [SharedData sharedData];
    
    NSMutableDictionary *properties = [[NSMutableDictionary alloc] init];
    [properties setObject:@"Test Form" forKey:@"title"];
    
    NSMutableDictionary *questions = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *questionItem = [[NSMutableDictionary alloc] init];
    [questionItem setObject:@"control_textbox" forKey:@"type"];
    [questionItem setObject:@"Name" forKey:@"text"];
    [questionItem setObject:@"1" forKey:@"order"];
    [questionItem setObject:@"textboxName" forKey:@"1"];

    [questions setObject:questionItem forKey:@"1"];

    questionItem = [[NSMutableDictionary alloc] init];
    [questionItem setObject:@"control_textarea" forKey:@"type"];
    [questionItem setObject:@"Message" forKey:@"text"];
    [questionItem setObject:@"2" forKey:@"order"];
    [questionItem setObject:@"textboxMessage" forKey:@"name"];
    
    [questions setObject:questionItem forKey:@"2"];
    
    NSMutableDictionary *form = [[NSMutableDictionary alloc] init];
    
    [form setObject:properties forKey:@"properties"];
    [form setObject:questions forKey:@"questions"];

    [sharedData.apiClient setDelegate:self];
    [sharedData.apiClient setDidFinishSelector:@selector(createFormFinish:)];
    [sharedData.apiClient setDidFailSelector:@selector(createFormFail:)];
    
    [sharedData.apiClient createForm:form];
}

#pragma mark - Jotform delegate

- (void) createFormFinish : (id) result
{
    [SVProgressHUD dismiss];
}

- (void) createFormFail : (id) error
{
    [SVProgressHUD dismiss];
}

@end
