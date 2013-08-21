//
//  JotFormTestViewController.h
//  JotFormTest
//
//  Created by Administrator on 6/26/13.
//  Copyright (c) 2013 Interlogy, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JotForm/JotForm.h>

@interface JotFormTestViewController : UIViewController<JotFormDelegate>
{
    IBOutlet UILabel            *resultLabel;
    
    JotForm                     *jotform;
}

@end
