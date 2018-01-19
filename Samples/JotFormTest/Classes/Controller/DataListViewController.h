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

- (void)setFormList:(NSArray *)datAarray type:(DataListType)type;
- (void)setSubmissionList:(NSArray *)dataArray type:(DataListType)type;
- (void)setReportList:(NSArray *)dataArray type:(DataListType)type;

@end
