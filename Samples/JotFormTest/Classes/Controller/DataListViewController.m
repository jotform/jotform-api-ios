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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - user definition method

- (void)setList:(NSArray *)dataArray type:(DataListType)type {
    listType = type;
    
    self.dataList = [[NSMutableArray alloc] initWithArray:dataArray];
    [self.listTableView reloadData];
    
    switch (listType) {
        case DataListTypeFormList:
            self.title = @"Form list";
            break;
        case DataListTypeSubmissionList:
            self.title = @"Submission list";
            break;
        default:
            self.title = @"Report list";
            break;
    }
    
    self.title = @"Form list";
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SampleCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SampleCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    id object = [self.dataList objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [object objectForKey:@"id"];
    
    if (listType == DataListTypeFormList || listType == DataListTypeReportList) {
        cell.textLabel.text = [object objectForKey:@"title"];
    }
    
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
