//
//  SampleListViewController.m
//  JotFormTest
//
//  Created by Administrator on 1/5/14.
//  Copyright (c) 2014 Interlogy, LLC. All rights reserved.
//

#import "SampleListViewController.h"
#import "GetFormReportsViewController.h"
#import "GetAllFormsViewController.h"
#import "GetAllSubmissionsViewController.h"
#import "CreateFormViewController.h"
#import "SharedData.h"

@interface SampleListViewController ()

@end

@implementation SampleListViewController

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
    
    self.title = @"API sample list";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SharedData *sharedData = [SharedData sharedData];
    
    return [sharedData.sampleStrList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SampleCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SampleCell"];
    }
    
    SharedData *sharedData = [SharedData sharedData];
    NSString *sampleStr = [sharedData.sampleStrList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = sampleStr;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;

    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ( indexPath.row == 0 ) {
        
        GetAllFormsViewController *getAllFormsVc = [[GetAllFormsViewController alloc] initWithNibName:@"GetAllFormsViewController" bundle:nil];
        
        [self.navigationController pushViewController:getAllFormsVc animated:YES];
        
    } else if ( indexPath.row == 1 ) {
        
        GetAllSubmissionsViewController *getAllSubmissionsVc = [[GetAllSubmissionsViewController alloc] initWithNibName:@"GetAllSubmissionsViewController" bundle:nil];
        
        [self.navigationController pushViewController:getAllSubmissionsVc animated:YES];
        
    } else if ( indexPath.row == 2 ) {
        
        GetFormReportsViewController *formReportVc = [[GetFormReportsViewController alloc] initWithNibName:@"GetFormReportsViewController" bundle:nil];
        
        [self.navigationController pushViewController:formReportVc animated:YES];
        
    } else if ( indexPath.row == 3 ) {
        
        CreateFormViewController *createFormVc = [[CreateFormViewController alloc] initWithNibName:@"CreateFormViewController" bundle:nil];

        [self.navigationController pushViewController:createFormVc animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
