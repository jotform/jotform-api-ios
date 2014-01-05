//
//  GetAllFormsViewController.h
//  JotFormTest
//
//  Created by Administrator on 1/6/14.
//  Copyright (c) 2014 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetAllFormsViewController : UIViewController
{
    IBOutlet UITableView        *mTableView;
    
    IBOutlet UITextField        *mOffsetTextField;
    IBOutlet UITextField        *mLimitTextField;
    IBOutlet UIPickerView       *mPickerView;
    IBOutlet UITextField        *mFilterTextField;
}

@end
