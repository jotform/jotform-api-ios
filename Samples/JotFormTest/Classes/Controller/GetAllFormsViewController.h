//
//  GetAllFormsViewController.h
//  JotFormTest
//
//  Created by Administrator on 1/6/14.
//  Copyright (c) 2014 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JotForm/JotForm.h>

@interface GetAllFormsViewController : UIViewController<JotFormDelegate>
{
    IBOutlet UITextField        *offsetTextField;
    IBOutlet UITextField        *limitTextField;
    IBOutlet UIPickerView       *pickerView;
    IBOutlet UITextField        *filterTextField;
    IBOutlet UIBarButtonItem    *getBarButtonItem;
    
    NSArray                     *orderbyList;
}

@end
