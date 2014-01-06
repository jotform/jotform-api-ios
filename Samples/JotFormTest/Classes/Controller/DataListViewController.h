//
//  DataListViewController.h
//  JotFormTest
//
//  Created by Administrator on 1/6/14.
//  Copyright (c) 2014 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataListViewController : UIViewController
{
    IBOutlet UITableView        *listTableView;
    
    NSMutableArray              *dataList;
}

- (void) setDataList : (NSArray *) dataarray;

@end
