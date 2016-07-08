//
//  DataListViewController.h
//  JotFormTest
//
//  Created by Interlogy, LLC on 1/6/14.
//  Copyright (c) 2014 Interlogy, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

@interface DataListViewController : UIViewController
{
    IBOutlet UITableView        *listTableView;
    NSMutableArray              *dataList;
    DataListType                 listType;
}

- (void) setFormList : (NSArray *) dataarray type : (DataListType) type;
- (void) setSubmissionList : (NSArray *) dataarray type : (DataListType) type;
- (void) setReportList : (NSArray *) dataarray type : (DataListType) type;

@end
