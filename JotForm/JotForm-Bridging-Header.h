//
//  JotForm-Bridging-Header.h
//  JotForm
//
//  Created by Curtis Stilwell on 1/21/18.
//  Copyright © 2018 Interlogy, LLC. All rights reserved.
//

#ifndef JotForm_Bridging_Header_h
#define JotForm_Bridging_Header_h

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#elif TARGET_OS_WATCH
#import <WatchKit/WatchKit.h>
#else
#import <Foundation/Foundation.h>
#endif

#import "AFHTTPSessionManager.h"

#endif /* JotForm_Bridging_Header_h */
