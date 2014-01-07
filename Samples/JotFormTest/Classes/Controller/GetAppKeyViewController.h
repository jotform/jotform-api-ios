//
//  GetAppKeyViewController.h
//  JotFormTest
//
//  Created by Interlogy, LLC on 1/5/14.
//  Copyright (c) 2014 Interlogy, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JotForm/JotForm.h>

@interface GetAppKeyViewController : UIViewController<JotFormDelegate>
{
    JotForm                     *apiClient;
    
    IBOutlet UITextField        *usernameTextField;
    IBOutlet UITextField        *passwordTextField;
}

@end
