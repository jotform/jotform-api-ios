//
//  JotForm.h
//  JotForm
//
//  Created by Wang YuPing on 7/9/13.
//  Copyright (c) 2013 Wang YuPing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "ASIFormDataRequest.h"
#import "SBJsonParser.h"

@protocol JotFormDelegate <NSObject>

- (void) requestFinished : (id) object;
- (void) requestFailed : (id) object;

@end

@interface JotForm : NSObject<ASIHTTPRequestDelegate>
{
    NSString        *apiKey;
    NSString        *baseUrl;
    NSString        *apiVersion;
    
    BOOL             debugMode;
}

- (id) initWithApiKey : (NSString *) apikey debugMode : (BOOL) debugmode;
- (id) getUser;
- (id) getUsage;
- (id) getForms;

@end
