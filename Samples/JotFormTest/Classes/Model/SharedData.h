//
//  SharedData.h
//  JotFormTest
//
//  Created by Administrator on 1/5/14.
//  Copyright (c) 2014 Interlogy, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JotForm/JotForm.h>

@interface SharedData : NSObject
{
    JotForm         *apiClient;
}

@property (nonatomic, retain) JotForm           *apiClient;
@property (nonatomic, retain) NSMutableArray    *sampleStrList;

+ (SharedData *) sharedData;
- (void) initSharedData;
- (void) initAPIClient : (NSString *) apiKey;

@end
