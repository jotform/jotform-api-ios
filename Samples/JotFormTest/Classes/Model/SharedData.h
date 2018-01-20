//
//  SharedData.h
//  JotFormTest
//
//  Created by Interlogy, LLC on 1/5/14.
//  Copyright (c) 2014 Interlogy, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JotForm_iOS/JotForm.h>

@interface SharedData : NSObject

@property (nonatomic, strong) JotForm *apiClient;
@property (nonatomic, strong) NSMutableArray *sampleStrList;

+ (SharedData *)sharedData;
- (void)initSharedData;
- (void)initAPIClient:(NSString *)apiKey euApi:(BOOL)euApi;
@property (NS_NONATOMIC_IOSONLY, getter=getFormOrderbyList, readonly, copy) NSArray *formOrderbyList;

@end
