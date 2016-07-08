//
//  RegisterUserViewController.h
//  JotFormTest
//
//  Created by Administrator on 1/8/14.
//  Copyright (c) 2014 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JotForm/JotForm.h>

@interface RegisterUserViewController : UIViewController
{
    IBOutlet UITextField        *mUsernameTextField;
    IBOutlet UITextField        *mPasswordTextField;
    IBOutlet UITextField        *mEmailTextField;
}

- (IBAction) registerButtonClicked : (id) sender;

@end
