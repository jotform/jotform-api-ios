//
//  GetFormPropertiesViewController.m
//  JotFormTest
//
//  Created by Curtis Stilwell on 8/21/17.
//  Copyright © 2017 wang. All rights reserved.
//

#import "GetFormPropertiesViewController.h"
#import "SharedData.h"
#import "Common.h"

@interface GetFormPropertiesViewController ()

@property (nonatomic, weak) IBOutlet UITextView *textView;

@end

@implementation GetFormPropertiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    SharedData *sharedData = [SharedData sharedData];
    
    [sharedData.apiClient getFormProperties:FORM_ID onSuccess:^(id result) {
        
        self.textView.text = [NSString stringWithFormat:@"%@",result];
   
    } onFailure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
