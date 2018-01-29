//
//  SharedData.m
//  JotFormTest
//
//  Created by Interlogy, LLC on 1/5/14.
//  Copyright (c) 2014 Interlogy, LLC. All rights reserved.
//

#import "SharedData.h"

static SharedData *g_sharedInfo = nil;

@implementation SharedData

- (instancetype)init {
    if (self = [super init] ) {
        [self initSharedData];
    }
    return self;
}

+ (SharedData *)sharedData {
    static SharedData *sharedData = nil;
  
    static dispatch_once_t onceToken; // onceToken = 0
    dispatch_once(&onceToken, ^{
        sharedData = [[SharedData alloc] init];
    });
    
    return sharedData;
}

- (void)initSharedData {
    NSString *sampleStr = @"Get all forms,Get all submissions,Get all reports,Create form,Create submission,Create report,Register user,Create question,Load settings,Get history,Get form properties,Create form properties,Create Forms,Create Form Questions";
    
    self.sampleStrList = (NSMutableArray *)[sampleStr componentsSeparatedByString:@","];
}

- (void)initAPIClient:(NSString *)apiKey euApi:(BOOL)euApi {
    self.apiClient = [[JotForm alloc] initWithApiKey:apiKey debugMode:YES euApi:euApi];
}

- (NSArray *)getFormOrderbyList {
    NSString *orderbyStr = @"id,username,title,status,created_at,updated_at,new,count,slug";
    NSArray *orderbyList = [orderbyStr componentsSeparatedByString:@","];
    
    return orderbyList;
}

@end
