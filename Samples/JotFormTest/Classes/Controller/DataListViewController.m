//
//  DataListViewController.m
//  JotFormTest
//
//  Created by Interlogy, LLC on 1/6/14.
//  Copyright (c) 2014 Interlogy, LLC. All rights reserved.
//

#import "DataListViewController.h"
#import "SharedData.h"
#import "Common.h"

@interface DataListViewController () {
           DataListType listType;
}

@property (nonatomic,weak) IBOutlet UITableView *listTableView;
@property (nonatomic,strong) NSMutableArray *dataList;

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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - user definition method

- (void) setFormList : (NSArray *) dataarray type : (DataListType) type
{
    listType = type;
    
    if (self.dataList == nil )
        self.dataList = [[NSMutableArray alloc] init];
    
    [self.dataList removeAllObjects];
    [self.dataList addObjectsFromArray:dataarray];
    [self.listTableView reloadData];
    
    self.title = @"Form list";
}

- (void) setSubmissionList : (NSArray *) dataarray type : (DataListType) type
{
    listType = type;
    
    if (!self.dataList)
        self.dataList = [[NSMutableArray alloc] init];
    
    [self.dataList removeAllObjects];
    [self.dataList addObjectsFromArray:dataarray];
    [self.listTableView reloadData];
    
    self.title = @"Submission list";
}

- (void) setReportList : (NSArray *) dataarray type : (DataListType) type
{
    listType = type;
    
    if (!self.dataList)
        self.dataList = [[NSMutableArray alloc] init];
    
    [self.dataList removeAllObjects];
    [self.dataList addObjectsFromArray:dataarray];
    [self.listTableView reloadData];
    
    self.title = @"Report list";
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
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SampleCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SampleCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    id object = [self.dataList objectAtIndex:indexPath.row];
    
    if (listType == DataListTypeFormList) {
        cell.textLabel.text = [object objectForKey:@"title"];
        cell.detailTextLabel.text = [object objectForKey:@"id"];
    } else if (listType == DataListTypeSubmissionList) {
        cell.detailTextLabel.text = [object objectForKey:@"id"];
    } else if (listType == DataListTypeReportList) {
        cell.textLabel.text = [object objectForKey:@"title"];
        cell.detailTextLabel.text = [object objectForKey:@"id"];
    }
    
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
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
}

@end
