//
//  GetHistoryViewController.m
//  JotFormTest
//
//  Created by Curtis Stilwell on 8/21/17.
//  Copyright © 2017 wang. All rights reserved.
//

#import "GetHistoryViewController.h"
#import "SharedData.h"

@interface GetHistoryViewController ()

@property (nonatomic, weak) IBOutlet UITextView *textView;

@end

@implementation GetHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SharedData *sharedData = [SharedData sharedData];
    
    [sharedData.apiClient getHistory:^(id result) {
      
        self.textView.text = [NSString stringWithFormat:@"%@",result];
   
    } onFailure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
