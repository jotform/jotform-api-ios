//
//  JotFormTestViewController.h
//  JotFormTest
//
//  Created by Administrator on 6/26/13.
//  Copyright (c) 2013 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JotForm/JotForm.h>

@interface JotFormTestViewController : UIViewController
{
    IBOutlet UILabel            *resultLabel;
    
    JotForm                     *jotform;
}

- (IBAction) getFormsButtonClicked : (id) sender;

@end
