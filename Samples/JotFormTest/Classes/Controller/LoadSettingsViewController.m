//
//  LoadSettingsViewController.m
//  JotFormTest
//
//  Created by Curtis Stilwell on 8/21/17.
//  Copyright © 2017 wang. All rights reserved.
//

#import "LoadSettingsViewController.h"
#import "SharedData.h"

@interface LoadSettingsViewController ()

@property (nonatomic, weak) IBOutlet UITextView *textView;

@end

@implementation LoadSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[SharedData sharedData].apiClient getSettings:^(id result) {
        
        self.textView.text = [NSString stringWithFormat:@"%@",result];
        
    } onFailure:^(NSError *error) {
        
    }];
}

@end
