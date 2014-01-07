//
//  DataListViewController.m
//  JotFormTest
//
//  Created by Interlogy, LLC on 1/6/14.
//  Copyright (c) 2014 Interlogy, LLC. All rights reserved.
//

#import "DataListViewController.h"
#import "SharedData.h"

@interface DataListViewController ()

@end

@implementation DataListViewController

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

- (void) setFormList : (NSArray *) dataarray type : (DataListType) type
{
    listType = type;
    
    if ( dataList == nil )
        dataList = [[NSMutableArray alloc] init];
    
    [dataList removeAllObjects];
    
    [dataList addObjectsFromArray:dataarray];
    
    [listTableView reloadData];
    
    self.title = @"Form list";
}

- (void) setSubmissionList : (NSArray *) dataarray type : (DataListType) type
{
    listType = type;
    
    if ( dataList == nil )
        dataList = [[NSMutableArray alloc] init];
    
    [dataList removeAllObjects];
    
    [dataList addObjectsFromArray:dataarray];
    
    [listTableView reloadData];
    
    self.title = @"Submission list";
}

- (void) setReportList : (NSArray *) dataarray type : (DataListType) type
{
    listType = type;
    
    if ( dataList == nil )
        dataList = [[NSMutableArray alloc] init];
    
    [dataList removeAllObjects];
    
    [dataList addObjectsFromArray:dataarray];
    
    [listTableView reloadData];
    
    self.title = @"Report list";
}

- (void) initUI
{
    
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
    return [dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SampleCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SampleCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    id form = [dataList objectAtIndex:indexPath.row];
    
    if ( listType == DataListTypeFormList ) {
        cell.textLabel.text = [form objectForKey:@"title"];
        cell.detailTextLabel.text = [form objectForKey:@"id"];
    } else if ( listType == DataListTypeSubmissionList ) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", form];
        cell.detailTextLabel.numberOfLines = 0;
    } else if ( listType == DataListTypeReportList ) {
        cell.textLabel.text = [form objectForKey:@"title"];
        cell.detailTextLabel.text = [form objectForKey:@"id"];
    }

    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( listType == DataListTypeSubmissionList ) {
    
        id submission = [dataList objectAtIndex:indexPath.row];
        
        NSString *submissionStr = [NSString stringWithFormat:@"%@", submission];
        
        CGSize labelSize = [submissionStr sizeWithFont:[UIFont systemFontOfSize:12.0]
                                    constrainedToSize:CGSizeMake(290, 9999)
                                        lineBreakMode:NSLineBreakByWordWrapping];
        
        CGFloat labelHeight = labelSize.height;

        return labelHeight;
    }
    
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ( indexPath.row == 0 ) {
        
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
