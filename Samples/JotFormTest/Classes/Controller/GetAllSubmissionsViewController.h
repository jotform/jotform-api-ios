//
//  GetAllSubmissionsViewController.h
//  JotFormTest
//
//  Created by Interlogy, LLC on 1/6/14.
//  Copyright (c) 2014 Interlogy, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JotForm/JotForm.h>

@interface GetAllSubmissionsViewController : UIViewController<JotFormDelegate>
{
    IBOutlet UITextField        *offsetTextField;
    IBOutlet UITextField        *limitTextField;
    IBOutlet UIPickerView       *pickerView;
    IBOutlet UITextField        *filterTextField;
    IBOutlet UIBarButtonItem    *getBarButtonItem;
    
    NSArray                     *orderbyList;
}

@end
