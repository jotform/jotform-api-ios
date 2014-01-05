//
//  GetAppKeyViewController.h
//  JotFormTest
//
//  Created by Administrator on 1/5/14.
//  Copyright (c) 2014 Interlogy, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JotForm/JotForm.h>

@interface GetAppKeyViewController : UIViewController<JotFormDelegate>
{
    JotForm                     *apiClient;
    
    IBOutlet UITextField        *mUsernameTextField;
    IBOutlet UITextField        *mPasswordTextField;
}

@end
