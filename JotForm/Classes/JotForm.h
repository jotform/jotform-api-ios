//
//  JotForm.h
//  JotForm
//
//  Created by Wang YuPing on 7/9/13.
//  Copyright 2013 Interlogy, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "ASIFormDataRequest.h"
#import "SBJsonParser.h"

typedef void (^JorFormBlock)(id);

@interface JotForm : NSObject<ASIHTTPRequestDelegate>
{
    NSString        *apiKey;
    NSString        *baseUrl;
    NSString        *apiVersion;
    
    BOOL             debugMode;
}

@property (nonatomic, retain) NSOperationQueue  *operationQueue;
@property (nonatomic, copy) JorFormBlock        didFinishBlock;
@property (nonatomic, copy) JorFormBlock        didFailBlock;

- (id) initWithApiKey : (NSString *) apikey debugMode : (BOOL) debugmode;
- (void) getUser;
- (void) getUsage;
- (void) getForms;

@end
