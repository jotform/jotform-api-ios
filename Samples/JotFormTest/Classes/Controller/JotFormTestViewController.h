//
//  JotFormTestViewController.h
//  JotFormTest
//
//  Created by Interlogy, LLC on 6/26/13.
//  Copyright (c) 2013 Interlogy, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JotForm/JotForm.h>

@interface JotFormTestViewController : UIViewController
{
    IBOutlet UILabel            *resultLabel;
    
    JotForm                     *jotform;
}

@end
