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

@interface CreateFormQuestionsViewController ()

@end

@implementation CreateFormQuestionsViewController {
    
}

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

- (void) createFormQuestions
{
    SharedData *sharedData = [SharedData sharedData];
    
    NSString *jsonString = @"{\"questions\":{\"1\":{\"type\":\"control_head\",\"text\":\"Text 1\",\"order\":\"1\",\"name\":\"Header1\"},\"2\":{\"type\":\"control_head\",\"text\":\"Text 2\",\"order\":\"2\",\"name\":\"Header2\"}}}";

  
    [sharedData.apiClient createFormQuestions:FORM_ID questions:jsonString onSuccess:^(id result){
        [SVProgressHUD dismiss];
        
        if (result != nil ) {
            
            int responseCode = [[result objectForKey:@"responseCode"] integerValue];
            
            if ( responseCode == 200 || responseCode == 206 ) {
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"JotFormAPISample" message:@"You created question successfully." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                
                [alertView show];
                
                return;
                
            }
        }
    } onFailure:^(id error) {
        
    }];
    
}

#pragma mark - IBAction

- (IBAction) createFormQuestionsClicked : (id) sender
{
    [self createFormQuestions];
}



@end